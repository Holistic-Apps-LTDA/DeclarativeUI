import DeclarativeUI

class PageControlViewController: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
        
    lazy var view = StackView(.vertical) {
        Spacer(.medium)
        PageControl()
            .numberOfPages(5)
        .padding(.horizontal(.small))
        Spacer(.flexible)
    }
}
