import UIKit

public struct Style {
    // Placeholder
}

public struct FontStyle {
    var kern: CGFloat
    var lineHeight: CGFloat
    var color: Color
    
    init(kern: CGFloat, lineHeight: CGFloat, color: Color) {
        self.kern = kern
        self.lineHeight = lineHeight
        self.color = color
    }
}
//
public typealias Font = UIFont

// MARK: - Text

public struct TextStyle: Equatable {
    let font: Font
    let fontStyle: FontStyle
    
    init(font: Font, fontStyle: FontStyle) {
        self.font = font
        self.fontStyle = fontStyle
    }
    
    public static func == (lhs: TextStyle, rhs: TextStyle) -> Bool {
        return lhs.font == rhs.font
            && lhs.fontStyle.color.value == rhs.fontStyle.color.value
            && lhs.fontStyle.kern == rhs.fontStyle.kern
            && lhs.fontStyle.lineHeight == rhs.fontStyle.lineHeight
    }
}

public extension TextStyle {
    
    static func systemFont(color: Color = .black,
                           ofSize: CGFloat = 15) -> TextStyle {
        return TextStyle(font: .systemFont(ofSize: ofSize),
                         fontStyle: FontStyle(kern: -0.4, lineHeight: 24, color: color)
        )
    }
    
    static func boldSystemFont(color: Color = .black,
                               ofSize: CGFloat = 15) -> TextStyle {
        return TextStyle(font: .boldSystemFont(ofSize: ofSize),
                         fontStyle: FontStyle(kern: -0.4, lineHeight: 20, color: color)
        )
    }
}

// MARK: - Color

public struct Color: Hashable {
    public let value: UIColor
    
    init(value: UIColor) {
        self.value = value
    }
}

public extension Color {
    static var black = Color(value: UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1))
    static var black2 = Color(value: UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.6))
    static var white = Color(value: UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1))
    static var clear = Color(value: .clear)
}
