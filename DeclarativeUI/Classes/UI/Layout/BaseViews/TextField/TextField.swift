import UIKit

public class TextField: DeclarativeView {
    var style: TextStyle
    private let paragraph = NSMutableParagraphStyle()
    private let textField = BaseTextField()
    public var placeholderLabel: Label
    public var icon = Image()
        .contentMode(.scaleAspectFill)
    
    public var rootView: BaseView { view.rootView }
    public let delegate: Delegate
    
    public init(style: TextStyle = .systemFont(),
                stylePlaceholder: TextStyle = .systemFont(color: .black2),
                alignment: NSTextAlignment = .left,
                icon: UIImage? = nil) {
        self.style = style
        self.placeholderLabel = Label(style: stylePlaceholder)
        if let icon = icon {
            self.icon = Image(icon)
        }
        self.icon.hidden(when: icon == nil)
        delegate = Delegate(maxLength: nil)
        
        paragraph.maximumLineHeight = style.fontStyle.lineHeight
        paragraph.alignment = alignment
        
        textField.delegate = delegate
        textField.accessibilityLabel = "Input Text Field"
        textField.addTarget(self, action: #selector(textFieldChangeEditing),
                            for: .editingChanged)
        textField.autocorrectionType = .no

        if #available(iOS 12, *) {
            textField.textContentType = .oneTimeCode
        } else {
            textField.textContentType = .init(rawValue: "")
        }

        setPlaceHolder(style: style)
    }

    private lazy var view = ContainerView {
        StackView(.horizontal) {
            ZStackView {
                textField
                placeholderLabel
            }
        }.subview(self.icon) { layout in
            layout.trailing(to: textField.trailingAnchor)
            layout.bottom(to: textField.bottomAnchor)
            layout.height(24)
            layout.width(24)
        }
    }

    public func text() -> String {
        return textField.text ?? ""
    }

    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        paragraph.alignment = alignment
        return self
    }

    @discardableResult
    public func accessoryView(_ value: UIView) -> Self {
        textField.inputAccessoryView = value
        return self
    }

    @discardableResult
    public func endEditing(_ value: Bool) -> Self {
        textField.endEditing(value)
        return self
    }

    @discardableResult
    public func placeholder(_ value: String) -> Self {
        placeholderLabel.text(value)
        return self
    }
    
    @discardableResult
    public func textFieldPlaceholder(_ value: String) -> Self {
        textField.placeholder = value
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
    
    @discardableResult
    public func isSecureText(_ value: Bool) -> Self {
        textField.isSecureTextEntry = value
        return self
    }

    @discardableResult
    public func enable(_ value: Bool) -> Self {
        textField.isEnabled = value
        return self
    }
    
    @discardableResult
    public func hideIcon(_ value: Bool) -> Self {
        icon.hidden(when: value)
        return self
    }

    @discardableResult
    public func icon(_ value: Image) -> Self {
        icon.image(value.image())
        icon.hidden(when: false)
        return self
    }

    @discardableResult
    public func keyboard(_ keyboard: UIKeyboardType) -> Self {
        textField.keyboardType = keyboard
        return self
    }
    
    @discardableResult
    public func inputType(_ view: UIView) -> Self {
        textField.inputView = view
        return self
    }

    @discardableResult
    public func text(_ value: String) -> Self {
        let attributedString = NSMutableAttributedString(string: value)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: style.fontStyle.color.value, range: range)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraph, range: range)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: style.fontStyle.kern, range: range)
        attributedString.addAttribute(NSAttributedString.Key.font, value: style.font, range: range)

        textField.attributedText = attributedString
        textField.adjustsFontSizeToFitWidth = true
        return self
    }

    @discardableResult
    public func shouldReturn(_ action: @escaping (TextField) -> Void) -> Self {
        observe(delegate.events.didShouldReturn) { view, _ in
            action(view)
        }
        return self
    }

    @discardableResult
    public func changeEditing(_ action: @escaping (TextField) -> Void) -> Self {
        observe(delegate.events.didChangeEditing) { view, textField in
            view.text(textField.text ?? "")
            action(view)
        }
        return self
    }

    @discardableResult
    public func beginEditing(_ action: @escaping (TextField) -> Void) -> Self {
        observe(delegate.events.didBeginEditing) { view, _ in
            action(view)
        }
        return self
    }

    @discardableResult
    public func endEditing(_ action: @escaping (TextField) -> Void) -> Self {
        observe(delegate.events.didEndEditing) { view, _ in
            action(view)
        }
        return self
    }

    @discardableResult
    public func deleteBackward(_ action: @escaping (TextField) -> Void) -> Self {
        observe(textField.events.deleteBackward) { view, _ in
            action(view)
        }
        return self
    }
    
    @discardableResult
    func placeholder(_ value: String, color: Color = .black) -> Self {
        textField.attributedPlaceholder = NSAttributedString(string: value, attributes: [NSAttributedString.Key.foregroundColor: color.value])
        return self
    }
    
    @discardableResult
    public func shouldChangeCharactersIn(_ action: @escaping (String) -> Void) -> Self {
        observe(delegate.events.shouldChangeCharactersIn) { _, value in
            action(value)
        }
        return self
    }
}

private extension TextField {
    @objc
    private func textFieldChangeEditing(_ sender: UITextField) {
        delegate.didChangeEditing(sender)
    }

    private func setPlaceHolder(style: TextStyle) {
        placeholderLabel = Label(text: " ", style: TextStyle(font: style.font, fontStyle: FontStyle(kern: style.fontStyle.kern, lineHeight: style.fontStyle.lineHeight, color: .black)))
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI.Group {
            ViewContainer(view: view)
                .previewDevice("iPhone 12")
        }
    }
    
    static var view = StackView(.vertical) {
        TextField(style: .systemFont())
        .placeholder("Placeholder")
        .backgroundColor(.white)
        .padding(.uniform(.extraLarge))
        .backgroundColor(.white)
        
        
        let icon = Icon(Icons.triangle, size: .small, color: .black).asImage()
        TextField(
            icon: icon
        )
        .placeholder("Banana")
        .changeEditing { text in
            print(text)
        }
        .padding(.uniform(.small))
    }
}
