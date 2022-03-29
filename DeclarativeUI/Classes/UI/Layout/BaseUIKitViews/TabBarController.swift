import UIKit

public final class TabBarController: UITabBarController, ObservableViewController {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
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

    override public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //super.tabBar(tabBar, didSelect: item)
        events.didSelect.publish(self)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) { nil }
}

public extension TabBarController {
    class Events: UIViewControllerEvents {
        public let viewDidLoad = Publisher<TabBarController>()
        public let viewWillAppear = Publisher<TabBarController>()
        public let viewDidAppear = Publisher<TabBarController>()
        public let viewWillDisappear = Publisher<TabBarController>()
        public let viewDidDisappear = Publisher<TabBarController>()
        public let didSelect = Publisher<TabBarController>()
    }
}
