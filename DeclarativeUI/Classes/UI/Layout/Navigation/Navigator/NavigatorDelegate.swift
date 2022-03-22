import UIKit

extension Navigator {
    class Delegate: NSObject, UINavigationControllerDelegate {
        let events = NavigationEvents()
        var transitioningDelegate: DeclarativeTransition? = nil
        struct NavigationEvents {
            public let willShowViewController = Publisher<UIViewController>()
            public let didShowViewController = Publisher<UIViewController>()
        }

        public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
            events.willShowViewController.publish(viewController)
        }
        
        public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
            events.didShowViewController.publish(viewController)
        }
        
        public func navigationController(_ navigationController: UINavigationController,
                                         animationControllerFor operation: UINavigationController.Operation,
                                         from fromVC: UIViewController,
                                         to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            switch operation {
            case .push:
                toVC.navigationController?.transitioningDelegate = transitioningDelegate
                transitioningDelegate?.isDismissing = false
            default:
                transitioningDelegate?.isDismissing = true
            }
            return transitioningDelegate
        }
    }
    
    class PopGestureDelegate: NSObject, UIGestureRecognizerDelegate {
        private weak var navigationController: UINavigationController?

        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
            super.init()
            enableGesture()
        }
        
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            let count = navigationController?.viewControllers.count ?? 0
            return count > 1
        }
        
        func disableGesture() {
            navigationController?.interactivePopGestureRecognizer?.delegate = self
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        func enableGesture() {
            navigationController?.interactivePopGestureRecognizer?.delegate = nil
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}
