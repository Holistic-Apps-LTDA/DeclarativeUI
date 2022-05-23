import DeclarativeUI

class ActivityIndicatorView: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    lazy var activityIndicator = ActivityIndicator()
        .color(.black)
    
    
    public init(navigator: Navigator) {
        self.navigator = navigator
        activityIndicator.startAnimating()
    }
    
    lazy var view = StackView(.vertical) {
        Spacer(.medium)
        activityIndicator
        Spacer(.flexible)
    }
}
