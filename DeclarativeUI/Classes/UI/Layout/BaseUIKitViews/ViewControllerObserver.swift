import UIKit

public class ViewControllerObserver<V: ObservableViewController>: DisposeManager {
    public struct ViewEvent {
        public var called: Bool = false
        public var viewController: V.Events.ViewController?
    }
    
    public var disposeBag = DisposeBag()
    public var viewDidLoad = ViewEvent()
    public var viewWillAppear = ViewEvent()
    public var viewDidAppear = ViewEvent()
    public var viewWillDisappear = ViewEvent()
    public var viewDidDisappear = ViewEvent()
    public var dismissed = ViewEvent()
    
    public init(viewController: V) {
        observe(viewController.events.viewDidLoad) { `self`, viewController in
            self.viewDidLoad.called = true
            self.viewDidLoad.viewController = viewController
        }
        
        observe(viewController.events.viewWillAppear) { `self`, viewController in
            self.viewWillAppear.called = true
            self.viewWillAppear.viewController = viewController
        }
        
        observe(viewController.events.viewDidAppear) { `self`, viewController in
            self.viewDidAppear.called = true
            self.viewDidAppear.viewController = viewController
        }
        
        observe(viewController.events.viewWillDisappear) { `self`, viewController in
            self.viewWillDisappear.called = true
            self.viewWillDisappear.viewController = viewController
        }
        
        observe(viewController.events.viewDidDisappear) { `self`, viewController in
            self.viewDidDisappear.called = true
            self.viewDidDisappear.viewController = viewController
        }
        
        observe(viewController.events.dismissed) { `self`, viewController in
            self.dismissed.called = true
            self.dismissed.viewController = viewController
        }
    }
}
