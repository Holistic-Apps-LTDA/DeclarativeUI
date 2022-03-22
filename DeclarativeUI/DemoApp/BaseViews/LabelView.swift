import DeclarativeUI

class LabelView: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    lazy var view = StackView(.vertical) {
        Spacer(.medium)
        Label(style: .systemFont())
            .text("Text")
            .padding(.horizontal(.small))
        Spacer(.medium)
        Label(style: .boldSystemFont())
            .text("Text")
            .padding(.horizontal(.small))
        Spacer(.flexible)
    }
}
