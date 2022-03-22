import DeclarativeUI

class PagerView: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    lazy var view = StackView(.vertical) {
        Spacer(.medium)
        Pager(["Option 1", "Option 2", "Option 3"])
            .didChangeValue{ index in
                print(index)
            }
        .padding(.horizontal(.small))
        Spacer(.flexible)
    }
}
