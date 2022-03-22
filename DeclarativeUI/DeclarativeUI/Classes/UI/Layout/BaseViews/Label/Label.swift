import UIKit

public class Label: DeclarativeView {
    var style: TextStyle
    public var rootView: BaseLabel { label }
    private let label = BaseLabel()
    private var alignment: TextAlignment = .natural
    
    init(style: TextStyle) {
        self.style = style
        numberOfLines(0)
        expansionResistance(.defaultHigh)
        compressionResistance(.required)
    }
    
    public convenience init(text: String = "",
                            style: TextStyle) {
        self.init(style: style)
        self.text(text)
    }
    
    public convenience init(text: AttributedString,
                            style: TextStyle) {
        self.init(style: style)
        self.text(text)
    }
    
    public convenience init(text: Observable<String>,
                            style: TextStyle) {
        self.init(style: style)
        observe(text) { label, value in
            label.text(value)
        }
    }
    
    @discardableResult
    public func alignment(_ alignment: TextAlignment) -> Self {
        label.textAlignment = alignment
        self.alignment = alignment
        return self
    }
    
    @discardableResult
    public func numberOfLines(_ value: Int) -> Self {
        label.numberOfLines = value
        return self
    }
    
    @discardableResult
    public func text(_ text: AttributedString) -> Self {
        label.attributedText = text
        alignment(alignment)
        return self
    }
    
    @discardableResult
    public func text(_ text: String) -> Self {
        return self.text(text.style(style))
    }
    
    @discardableResult
    public func text(_ text: String, animated: Bool) -> Self {
        guard animated else {
            return self.text(text)
        }
        transition.fade { `self` in
            self.text(text)
        }
        return self
    }
    
    @discardableResult
    public func text(_ text: Observable<String>) -> Self {
        observe(text) { label, value in
            label.text(value)
        }
        return self
    }

    @discardableResult
    public func text(_ text: Observable<AttributedString>) -> Self {
        observe(text) { label, value in
            label.text(value)
        }
        return self
    }

    @discardableResult
    public func style(_ style: TextStyle) -> Self {
        self.style = style
        text(label.text ?? "")
        return self
    }
    
    @discardableResult
    public func adjustsFontSizeToFitWidth(_ value: Bool) -> Self {
        label.adjustsFontSizeToFitWidth = value
        return self
    }
    
    @discardableResult
    public func lineBreakMode(_ value: NSLineBreakMode) -> Self {
        label.lineBreakMode = value
        return self
    }
}
