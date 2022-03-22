public struct FontIcon: Hashable {
    public let name: String
    public let unicode: String
    public let font: Font
        
    public init(name: String, unicode: String, font: Font) {
        self.name = name
        self.unicode = unicode
        self.font = font
    }
    
    public static let empty = FontIcon(name: "Empty", unicode: "", font: .systemFont(ofSize: 15))

    public static func icon(_ unicode: String) -> FontIcon {
        return FontIcon(name: "Custom", unicode: unicode, font: .systemFont(ofSize: 15))
    }
}
