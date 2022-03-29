import UIKit

public protocol ObservableViewController: UIViewController, DisposeManager {
    associatedtype Events: UIViewControllerEvents
    var events: Events { get }
}

public protocol UIViewControllerEvents {
    associatedtype ViewController: ObservableViewController
    
    var viewDidLoad: Publisher<ViewController> { get }
    var viewWillAppear: Publisher<ViewController> { get }
    var viewDidAppear: Publisher<ViewController> { get }
    var viewWillDisappear: Publisher<ViewController> { get }
    var viewDidDisappear: Publisher<ViewController> { get }
}

public extension UIViewControllerEvents {
    var dismissed: Publisher<ViewController> {
        viewDidDisappear.filter { viewController in
            guard viewController.parent == nil else { return false }
            guard viewController.presentingViewController == nil else { return false }
            return true
        }
    }
}
