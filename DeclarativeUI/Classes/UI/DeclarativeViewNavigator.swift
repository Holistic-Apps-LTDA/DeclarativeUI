import UIKit

public protocol DeclarativeViewNavigator: DeclarativeViewController {
    var navigator: Navigator { get }
}

public extension DeclarativeViewNavigator {
    var viewController: NavigationController {
        navigator.viewController
    }
}
