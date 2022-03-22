import UIKit

public typealias AttributedString = NSAttributedString

public extension String {
    func style(_ style: TextStyle, lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> AttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = style.fontStyle.lineHeight - style.font.pointSize
        paragraph.lineBreakMode = lineBreakMode
        attributedString.addAttributes([
            AttributedString.Key.foregroundColor: style.fontStyle.color.value,
            AttributedString.Key.paragraphStyle: paragraph,
            AttributedString.Key.kern: style.fontStyle.kern,
            AttributedString.Key.font: style.font,
        ], range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}

public func + (lhs: AttributedString, rhs: AttributedString) -> AttributedString {
    let mutable = NSMutableAttributedString(attributedString: lhs)
    mutable.append(rhs)
    return mutable
}
