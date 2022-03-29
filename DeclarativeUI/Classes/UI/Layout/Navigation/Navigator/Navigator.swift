import UIKit

public class Navigator: DeclarativeViewController {
    public var viewController: NavigationController { navigationController }
    private let navigationController = NavigationController()
    public let navigationBar: NavigationBar
    private var delegate = Delegate()
    private var popGestureDelegate: PopGestureDelegate
    public var enablePopGesture = false
    public private(set) var viewControllers = [UIViewController: UIViewControllerConvertible]()
    private weak var dismissInterceptor: DismissInterceptor?
    private weak var backInterceptor: BackInterceptor?
    private var transition = DeclarativeTransition()

    // MARK: Init
    
    public init(transition: DeclarativeTransition = DeclarativeTransition(),
                backIcon: Image,
                closeIcon: Image) {
        popGestureDelegate = PopGestureDelegate(navigationController: navigationController)
        navigationBar = NavigationBar(backIcon: backIcon, closeIcon: closeIcon)
        setupNavigationController()
        setupNavigationBar()
        setupObservers()
        setupCustomTransition(transition)
    }

    public convenience init(root: UIViewControllerConvertible,
                            transition: DeclarativeTransition = DeclarativeTransition(),
                            backIcon: Image,
                            closeIcon: Image) {
        self.init(transition: transition, backIcon: backIcon, closeIcon: closeIcon)
        push(root, animated: false)
    }
}

// MARK: Navigation

public extension Navigator {
    func push(_ viewController: UIViewControllerConvertible,
              animated: Bool = true,
              completion: (() -> Void)? = nil) {
        addChild(viewController)
        popGestureDelegate.disableGesture()
        onDidShow(viewController: viewController, completion: completion)
        navigationController.pushViewController(viewController.uiViewController, animated: animated)
    }
    
    func pushAndReplace(_ viewController: UIViewControllerConvertible,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil) {
        let topViewController = navigationController.topViewController
        push(viewController, animated: animated) { [weak self] in
            topViewController?.removeFromParent()
            self?.removeChild(topViewController)
            completion?()
        }
    }
    
    /// Presents a DeclarativeViewController saving it's reference
    /// The view controlller dismissed event is observed to free the memory once the DeclarativeViewController
    /// is not needed anymore
    /// - Parameters:
    ///   - viewController: The view controller to display over the current view controller’s content.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes.
    func present<T: DeclarativeViewController>(_ viewController: T,
                                         animated: Bool = true,
                                         completion: (() -> Void)? = nil) {
        addChild(viewController)
        removeChildOnDismiss(viewController)
        present(viewController.uiViewController,
                animated: animated,
                modalPresentationStyle: viewController.modalPresentationStyle,
                completion: completion)
    }
    
    /// Presents a UIViewController
    /// - Parameters:
    ///   - viewController: The view controller to display over the current view controller’s content.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes.
    func present(_ viewController: UIViewController,
                 animated: Bool = true,
                 modalPresentationStyle: UIModalPresentationStyle = .overFullScreen,
                 completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = modalPresentationStyle
        getPresenter().present(viewController,
                               animated: animated,
                               completion: completion)
    }
    
    func getPresenter() -> UIViewController {
        var presenter: UIViewController = navigationController
        while let presented = presenter.presentedViewController {
            presenter = presented
        }
        return presenter
    }

    func setViewControllers(_ viewControllers: [UIViewControllerConvertible], animated: Bool) {
        self.viewControllers = [:]
        let uiViewControllers: [UIViewController] = viewControllers.map { viewController in
            self.addChild(viewController)
            return viewController.uiViewController
        }
        navigationController.setViewControllers(uiViewControllers, animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func goBack(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let viewController = navigationController.topViewController else { completion?(); return }
        guard let previousViewController = viewControllerBefore(viewController) else { completion?(); return }
        onDidShow(viewController: previousViewController) { [weak self] in
            self?.removeChild(viewController)
            completion?()
        }
        navigationController.popViewController(animated: animated)
    }

    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
}

// MARK: Navigation Bar

public extension Navigator {
    func navigationBarHidden(_ hidden: Bool, animated: Bool) {
        // TODO: make the height dynamic
        let insets: UIEdgeInsets = hidden || navigationBar.isTransparent ? .top(.zero) : .top(.extraLarge3)
        
        if #available(iOS 11.0, *) {
            navigationController.topViewController?.additionalSafeAreaInsets = insets
        } 
        
        switch animated {
        case true:
            navigationBar.animation.fade(.hide(when: hidden))
        case false:
            navigationBar.hidden(when: hidden)
        }
    }
}

// MARK: Setup

private extension Navigator {
    func setupNavigationController() {
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.navigator = self
        navigationController.delegate = delegate
    }

    func setupNavigationBar() {
        navigationController.view.layout
            .addSubview(navigationBar) { layout in
                layout.topToSuperview()
                layout.leadingToSuperview()
                layout.trailingToSuperview()
            }

        navigationBar.backButton.onTap(weak: self) { `self` in
            if let interceptor = self.backInterceptor {
                return interceptor.interceptBack(navigator: self)
            }
            self.goBack()
        }

        navigationBar.closeButton.onTap(weak: self) { `self` in
            if let interceptor = self.dismissInterceptor {
                return interceptor.interceptClose(navigator: self)
            }
            self.dismiss()
        }
    }

    func setupObservers() {
        observe(delegate.events.didShowViewController) { `self`, _ in
            if self.enablePopGesture {
                self.popGestureDelegate.enableGesture()
            }
        }

        observe(delegate.events.willShowViewController) { `self`, viewController in
            self.navigationBar.title(viewController.title ?? "", animated: true)

            self.setupNavigationBarStyle(with: viewController)
            self.setupNavigationBarCustomButtons(with: viewController)
            self.setupNavigationBarOptions(with: viewController)
            self.setupProgress(with: viewController)
        }
    }
    
    func setupCustomTransition(_ transition: DeclarativeTransition) {
        guard transition.transitionType != .default else { return }
        self.transition = transition
        navigationController.modalPresentationStyle = .custom
        navigationController.transitioningDelegate = transition
        delegate.transitioningDelegate = transition
    }
}

// MARK: NavigationBarConfigurator

private extension Navigator {
    func setupNavigationBarStyle(with viewController: UIViewController) {
        guard let configurator = viewController as? NavigationBarConfigurator else { return }
        let style = configurator.navigationBarConfiguration.style
        navigationBar.style(style)
    }
    
    func setupProgress(with viewController: UIViewController) {
        guard let viewController = viewController as? NavigationBarConfigurator else { return }
        let progress = viewController.navigationBarConfiguration.progress
        navigationBar.progressBar.progress(progress.current, of: progress.total)
    }
    
    func setupNavigationBarOptions(with viewController: UIViewController) {
        guard let configurator = viewController as? NavigationBarConfigurator else { return }
        let config = configurator.navigationBarConfiguration
        
        navigationBarHidden(config.hidden, animated: true)

        navigationBar.backButton
            .animation.fade(
                .show(when: config.options.contains(.back) && isRoot(viewController) == false)
            )
        
        let isPresented = navigationController.presentingViewController != nil
        navigationBar.closeButton
            .animation.fade(
                .show(when: config.options.contains(.close) && isPresented)
            )
    }
    
    func setupNavigationBarCustomButtons(with viewController: UIViewController) {
        guard let configurator = viewController as? NavigationBarConfigurator else { return }
        let config = configurator.navigationBarConfiguration
        navigationBar.leftButton(config.leftButton)
        navigationBar.rightButton(config.rightButton)
    }
}

// MARK: Helpers

private extension Navigator {
    func onDidShow(viewController: UIViewControllerConvertible, completion: (() -> Void)?) {
        guard let completion = completion else { return }
        observe(delegate.events.didShowViewController) { _, pushedViewController, subscriber in
            guard viewController.uiViewController == pushedViewController else { return }
            completion()
            subscriber.cancel()
        }
    }
    
    func removeChildOnDismiss<T: DeclarativeViewController>(_ DeclarativeViewController: T) {
        DeclarativeViewController.viewController
            .events.dismissed
            .subscribe().onNext { [weak self] subscriber, viewController in
                self?.removeChild(viewController)
                subscriber.cancel()
            }.disposedBy(self)
    }
    
    func isRoot(_ viewController: UIViewControllerConvertible) -> Bool {
        viewController.uiViewController == navigationController.viewControllers.first
    }
    
    func viewControllerBefore(_ viewController: UIViewControllerConvertible) -> UIViewController? {
        guard let index = navigationController.viewControllers.firstIndex(of: viewController.uiViewController) else { return nil }
        return navigationController.viewControllers.element(at: index - 1)
    }
    
    func addChild(_ viewController: UIViewControllerConvertible) {
        viewControllers[viewController.uiViewController] = viewController
    }
    
    func removeChild(_ viewController: UIViewControllerConvertible?) {
        guard let viewController = viewController else { return }
        viewControllers.removeValue(forKey: viewController.uiViewController)
    }
}

public extension Navigator {
    @discardableResult
    func dismissInterceptor(_ interceptor: DismissInterceptor) -> Self {
        dismissInterceptor = interceptor
        return self
    }
    
    @discardableResult
    func backInterceptor(_ interceptor: BackInterceptor) -> Self {
        backInterceptor = interceptor
        return self
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct Navigator_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerContainer(view: navigator)
    }

    static var navigator = configure(Navigator(backIcon: Image(Icon(Icons.back, size: .medium, color: .black).asImage()), closeIcon: Image(Icon(Icons.close, size: .medium, color: .black).asImage()))) { navigator in
        let view = EmptyView().backgroundColor(.white)
        navigator
            .push(ViewController(view: view).title("Navigation"))
    }
}
