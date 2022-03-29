import UIKit

public class TextFieldAnimated: DeclarativeView {
    private let textField: TextField
    private var stackView = StackView(.vertical)
    public var rootView: BaseStackView { stackView.rootView }

    public init(style: TextStyle = .systemFont(),
                stylePlaceholder: TextStyle = .systemFont(color: .black2),
                alignment: NSTextAlignment = .left,
                icon: UIImage? = nil) {
        textField = TextField(
            style: style,
            stylePlaceholder: stylePlaceholder,
            alignment: alignment,
            icon: icon
        )
        
        stackView = StackView(.vertical) { [weak self] in
            textField
                .beginEditing { [weak self] textField in
                    self?.animatePlaceHolderUp()
                }
                .endEditing { [weak self] textField in
                    self?.animatePlaceHolder(text: textField.text())
                }
                .changeEditing { [weak self] textField in
                    self?.animatePlaceHolder(text: textField.text())
                }
                .shouldReturn { [weak self] textField in
                    self?.animatePlaceHolder(text: textField.text())
                }
        }
    }
    
    public func placeHolderLabel() -> Label {
        return textField.placeholderLabel
    }
    
    public func text() -> String {
        return textField.text()
    }
    
    @discardableResult
    public func endEditing(_ value: Bool) -> Self {
        textField.endEditing(value)
        return self
    }

    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        textField.alignment(alignment)
        return self
    }

    @discardableResult
    public func accessoryView(_ value: UIView) -> Self {
        textField.accessoryView(value)
        return self
    }

    @discardableResult
    public func placeholder(_ value: String) -> Self {
        textField.placeholder(value)
        return self
    }
    
    @discardableResult
    public func textFieldPlaceholder(_ value: String) -> Self {
        textField.textFieldPlaceholder(value)
        return self
    }
    
    @discardableResult
    public func isSecureText(_ value: Bool) -> Self {
        textField.isSecureText(value)
        return self
    }
    
    @discardableResult
    public func enable(_ value: Bool) -> Self {
        textField.enable(value)
        return self
    }
    
    @discardableResult
    public func hideIcon(_ value: Bool) -> Self {
        textField.hideIcon(value)
        return self
    }

    @discardableResult
    public func icon(_ value: Image) -> Self {
        textField.icon(value)
        return self
    }

    @discardableResult
    public func keyboard(_ keyboard: UIKeyboardType) -> Self {
        textField.keyboard(keyboard)
        return self
    }
    
    @discardableResult
    public func inputType(_ view: UIView) -> Self {
        textField.inputType(view)
        return self
    }
    
    @discardableResult
    public func text(_ value: String) -> Self {
        textField.text(value)
        animatePlaceHolder(text: textField.text())
        return self
    }

    @discardableResult
    public func shouldReturn(_ action: @escaping (TextField) -> Void) -> Self {
        textField.shouldReturn(action)
        return self
    }

    @discardableResult
    public func changeEditing(_ action: @escaping (TextField) -> Void) -> Self {
        textField.changeEditing(action)
        return self
    }

    @discardableResult
    public func beginEditing(_ action: @escaping (TextField) -> Void) -> Self {
        textField.beginEditing(action)
        return self
    }

    @discardableResult
    public func endEditing(_ action: @escaping (TextField) -> Void) -> Self {
        textField.endEditing(action)
        return self
    }
    
    @discardableResult
    public func shouldChangeCharactersIn(_ action: @escaping (String) -> Void) -> Self {
        textField.shouldChangeCharactersIn(action)
        return self
    }
    
    @discardableResult
    public func deleteBackward(_ action: @escaping (TextField) -> Void) -> Self {
        textField.deleteBackward(action)
        return self
    }
    
    @discardableResult
    public func becomeFirstResponder() -> Self {
        textField.becomeFirstResponder()
        return self
    }
    
    @discardableResult
    public func resignFirstResponder() -> Self {
        textField.resignFirstResponder()
        return self
    }
}

private extension TextFieldAnimated {
    
    private func animatePlaceHolder(text: String) {
        if !text.isEmpty {
            animatePlaceHolderUp()
        } else {
            animatePlaceHolderDown()
        }
    }
    
    private func animatePlaceHolderUp() {
        Animator().animate {
            self.textField.placeholderLabel.rootView.transform = CGAffineTransform(translationX: 0, y: -self.textField.placeholderLabel.rootView.frame.height)
        }
        .start(delay: .default)
        
    }
    
    private func animatePlaceHolderDown() {
        Animator().animate {
            self.textField.placeholderLabel.rootView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        .start(delay: .default)
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct TextFieldAnimated_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI.Group {
            ViewContainer(view: view)
                .previewDevice("iPhone 12")
        }
    }
    
    static var view = StackView(.vertical) {
        TextFieldAnimated()
            .placeholder("TextFieldAnimated")
            .padding(.uniform(.medium))
    }
}
