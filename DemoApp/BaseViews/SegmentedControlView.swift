import DeclarativeUI

class SegmentedControlView: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    lazy var view = StackView(.vertical) {
        Spacer(.medium)
        SegmentedControl(["Option 1", "Option 2"])
            .didChangeValue{ index in
                print(index)
            }
        .padding(.horizontal(.small))
        Spacer(.flexible)
    }
}
