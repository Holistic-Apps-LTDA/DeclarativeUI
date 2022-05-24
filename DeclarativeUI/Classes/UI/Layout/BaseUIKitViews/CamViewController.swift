import SwiftUI
import UIKit
import AVFoundation

public class CamViewController: UIViewController, ObservableViewController, NavigationBarConfigurator, StatusBarConfigurator {
    public var navigationBarConfiguration = NavigationBarConfiguration(hidden: true)
    
    public struct SafeAreaViews {
        public let top = EmptyView()
        public let bottom = EmptyView()
        
        init() {
            top.backgroundColor(.clear)
            bottom.backgroundColor(.clear)
        }
    }

    public let safeArea = SafeAreaViews()
    public var disposeBag = DisposeBag()
    let contentView: UIViewConvertible
    public let events = Events()
    private let stackView = StackView(.vertical)

    public var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public init(view: UIViewConvertible) {
        contentView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle { statusBarStyle }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = contentView.uiView.backgroundColor ?? .clear
        view.layout.addSubview(stackView)
        stackView.layout.edgesToSuperview()
        
        stackView.update {
            safeArea.top
            contentView
            safeArea.bottom
        }
        events.viewDidLoad.publish(self)
    }
    
    public var cameraView: CameraView {
        guard let cameraView = view as? CameraView else {
            fatalError("view should be of type `CameraView` on this view controller.\nPlease check `loadView` method on this class.")
        }
        
        return cameraView
    }
    
    override public func loadView() {
        view = CameraView()
    }
    
    override public func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        safeArea.top.layout.height(view.safeAreaInsets.top)
        safeArea.bottom.layout.height(view.safeAreaInsets.bottom)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        events.viewWillAppear.publish(self)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        events.viewDidAppear.publish(self)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        events.viewWillDisappear.publish(self)
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        events.viewDidDisappear.publish(self)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) { nil }
}

public class CameraView: UIView {
    public var videoLayer: AVCaptureVideoPreviewLayer {
        return layer as? AVCaptureVideoPreviewLayer ?? AVCaptureVideoPreviewLayer()
    }
    
    override public class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}

public extension CamViewController {
    class Events: UIViewControllerEvents {
        public let viewDidLoad = Publisher<CamViewController>()
        public let viewWillAppear = Publisher<CamViewController>()
        public let viewDidAppear = Publisher<CamViewController>()
        public let viewWillDisappear = Publisher<CamViewController>()
        public let viewDidDisappear = Publisher<CamViewController>()
    }
}

public extension CamViewController {
    @discardableResult
    func statusBarStyle(_ style: UIStatusBarStyle) -> Self {
        statusBarStyle = style
        return self
    }
    
    @discardableResult
    func tabBarItem(_ item: TabBarItem) -> Self {
        tabBarItem = item
        return self
    }
    
    @discardableResult
    func safeAreaColor(_ color: Color) -> Self {
        topSafeAreaColor(color)
        bottomSafeAreaColor(color)
        return self
    }
    
    @discardableResult
    func topSafeAreaColor(_ color: Color) -> Self {
        safeArea.top.backgroundColor(color)
        return self
    }
    
    @discardableResult
    func bottomSafeAreaColor(_ color: Color) -> Self {
        safeArea.bottom.backgroundColor(color)
        return self
    }
    
    @discardableResult
    func hiddenSafeArea() -> Self {
        safeArea.top.hidden()
        safeArea.bottom.hidden()
        return self
    }
    
    @discardableResult
    func title(_ title: String?, animated: Bool = true) -> Self {
        self.title = title
        navigationBar?.title(title, animated: animated)
        return self
    }
    
    @discardableResult
    func dismissKeboardWhenClicked() -> Self {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGesture)
        return self
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
}
    
public extension CamViewController {
    var navigator: Navigator? {
        guard let navigationController = navigationController as? NavigationController else { return nil }
        return navigationController.navigator
    }
    
    var navigationBar: NavigationBar? {
        navigator?.navigationBar
    }
}
