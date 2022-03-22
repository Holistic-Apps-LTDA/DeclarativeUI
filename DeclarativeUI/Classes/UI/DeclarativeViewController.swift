import UIKit

public protocol DeclarativeViewController: UIViewControllerConvertible, DisposeManager {
    associatedtype Controller: ObservableViewController
    var viewController: Controller { get }
    var modalPresentationStyle: UIModalPresentationStyle { get }
}

public extension DeclarativeViewController {
    var uiViewController: UIViewController { viewController }
    var modalPresentationStyle: UIModalPresentationStyle { .overFullScreen }
    var disposeBag: DisposeBag { viewController.disposeBag }
    
    @discardableResult
    func navigationTitle(_ title: String) -> Self {
        viewController.title = title
        return self
    }
    
    @discardableResult
    func userInteractionEnabled(when value: Publisher<Bool>) -> Self {
        observe(value) { view, value in
            view.viewController.view.window?.isUserInteractionEnabled = value
        }
        return self
    }
    
}
