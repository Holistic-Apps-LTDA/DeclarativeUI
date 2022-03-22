import UIKit

public class WebViewController: WebViewType, DeclarativeViewNavigator {
    public var viewController: NavigationController { navigator.viewController }
    
    public lazy var navigator = Navigator(root: rootViewController, backIcon: Image(Icon(Icons.back, size: .medium, color: .black).asImage()), closeIcon: Image(Icon(Icons.close, size: .medium, color: .black).asImage()))
        .backInterceptor(self)
    public lazy var rootViewController = ViewController(view: webView)
    private var navigationBar: NavigationBar { navigator.navigationBar }
    public let webView = WebView()
    private var adjustsWebViewForKeyboard = true
    
    public init() {
        setupObservers()
    }
    
    deinit {
        stopLoading()
        disposeBag.disposeAll()
    }
}

public extension WebViewController {
    @discardableResult
    func title(_ value: String?) -> Self {
        rootViewController.title(value, animated: false)
        return self
    }
    
    @discardableResult
    func adjustsWebViewForKeyboard(_ value: Bool) -> Self {
        adjustsWebViewForKeyboard = value
        return self
    }
}

private extension WebViewController {
    func setupObservers(notificationCenter: NotificationCenter = .default) {
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        observe(viewController.events.viewWillAppear) { `self`, viewController in
            let isPresented = viewController.presentingViewController != nil
            self.navigationBar.closeButton.hidden(when: isPresented == false)
        }
        
        observe(webView.title) { `self`, title in
            guard self.rootViewController.title == nil else { return }
            self.title(title)
        }
        
        navigationBar.backButton.hidden()
        navigationBar.leftButton.hidden(when: false)
        observe(webView.canGoBack) { `self`, canGoBack in
            self.navigationBar.backButton.animation.fade(.show(when: canGoBack))
            self.navigationBar.leftButton.hidden(when: canGoBack)
        }
        
        webView.showProgress(in: navigationBar.progressBar)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard adjustsWebViewForKeyboard else { return }
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let view = webView.rootView
        let keyboardViewEndFrame = view.convert(keyboardValue.cgRectValue, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            rootViewController.additionalSafeAreaInsets = .zero
        } else {
            rootViewController.additionalSafeAreaInsets = .bottom(keyboardViewEndFrame.height - viewController.view.safeAreaInsets.bottom)
        }
    }
}

extension WebViewController: BackInterceptor {
    public func interceptBack(navigator: Navigator) {
        webView.goBack()
    }
}

// MARK: Sample

import protocol SwiftUI.PreviewProvider
import protocol SwiftUI.View
@available(iOS 13.0.0, *)
struct WebViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerContainer(view: WebViewController())
    }
}
