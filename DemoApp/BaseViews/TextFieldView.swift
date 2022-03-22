import DeclarativeUI

class TextFieldView: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    lazy var view = StackView(.vertical) {
        Spacer(.large)
        TextFieldAnimated()
        .placeholder("Placeholder")
        .changeEditing { textField in
            print(textField.text())
        }
        .shouldReturn { textField in
            textField.endEditing(true)
        }
        .padding(.horizontal(.small))
        Spacer(.large)
        TextFieldAnimated(icon: DemoImage.close)
        .placeholder("Placeholder")
        .changeEditing { textField in
            print(textField.text())
        }
        .shouldReturn { textField in
            textField.endEditing(true)
        }
        .padding(.horizontal(.small))
        Spacer(.flexible)
    }
}
