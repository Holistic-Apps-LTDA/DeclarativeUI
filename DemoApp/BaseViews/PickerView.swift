import DeclarativeUI

class PickerViewController: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    @ObservableProperty var rows = Array(repeating: "Opções", count: 40)
    
    lazy var view = StackView(.vertical) {
        Spacer(.medium)
        PickerView {
            rows
        }.didSelectRow{ value in
            print(value)
        }
        .padding(.horizontal(.small))
        Spacer(.flexible)
    }
}
