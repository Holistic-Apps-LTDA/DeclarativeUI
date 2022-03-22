import UIKit

public final class NavigationController: UINavigationController, ObservableViewController {
    public var disposeBag = DisposeBag()
    public let events = Events()
    public weak var navigator: Navigator?
    
    // MARK: Styling
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    // MARK: Lifecycle
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setNavigationBarHidden(true, animated: false)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        events.viewDidLoad.publish(self)
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

public extension NavigationController {
    class Events: UIViewControllerEvents {
        public let viewDidLoad = Publisher<NavigationController>()
        public let viewWillAppear = Publisher<NavigationController>()
        public let viewDidAppear = Publisher<NavigationController>()
        public let viewWillDisappear = Publisher<NavigationController>()
        public let viewDidDisappear = Publisher<NavigationController>()
    }
}
