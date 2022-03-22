import UIKit

public typealias Icons = FontIcon.Kit

public class Icon: DeclarativeView {
    private var icon: FontIcon
    private let color: Color
    private let size: Size
    public var rootView: BaseLabel { label }
    private let label = BaseLabel()

    private init(icon: FontIcon, size: Size, color: Color) {
        self.icon = icon
        self.size = size
        self.color = color

        label.textColor = color.value
        label.text = icon.unicode
        label.font = icon.font
    }

    public convenience init(_ icon: FontIcon, size: Size, color: Color) {
        self.init(icon: icon, size: size, color: color)
        self.icon(icon)
    }

    public convenience init(_ icon: Observable<FontIcon>, size: Size, color: Color) {
        self.init(icon: icon.value, size: size, color: color)
        observe(icon) { view, value in
            view.icon(value)
        }
    }

    @discardableResult
    public func icon(_ icon: FontIcon) -> Self {
        self.icon = icon
        label.text = icon.unicode
        label.font = icon.font
        return self
    }

    @discardableResult
    func color(_ color: Color) -> Self {
        label.textColor = color.value
        return self
    }

    @discardableResult
    public func alignment(_ alignment: TextAlignment) -> Self {
        label.textAlignment = alignment
        return self
    }
}

public extension Icon {
    struct Size {
        public var value: CGFloat
        private init(_ value: CGFloat) {
            self.value = value
        }

        /// 16 pt
        public static let extraSmall = Size(16)
        /// 20 pt
        public static let small = Size(20)
        /// 24 pt
        public static let medium = Size(24)
        /// 32 pt
        public static let large = Size(32)
        /// 40 pt
        public static let extraLarge = Size(40)
        /// 56 pt
        public static let extraLarge2 = Size(56)

        public static let all = [
            extraSmall,
            small,
            medium,
            large,
            extraLarge,
        ]
    }
}

public extension Icon {
    func asImage() -> UIImage {
        let string = icon.unicode as NSString
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color.value,
            .font: icon.font,
        ]

        let size = string.size(withAttributes: attributes)
        return UIGraphicsImageRenderer(size: size).image { _ in
            string.draw(in: CGRect(origin: .zero, size: size),
                        withAttributes: attributes)
        }
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        ViewContainer(view: view)
    }

    static var view: StackView {
        StackView(.vertical) {
            Icon(Icons.triangle, size: .extraSmall, color: .black)
            Icon(Icons.triangle, size: .small, color: .black)
            Icon(Icons.triangle, size: .medium, color: .black)
            Icon(Icons.triangle, size: .large, color: .black)
            Icon(Icons.triangle, size: .extraLarge, color: .black)
            Icon(Icons.triangle, size: .extraLarge2, color: .black)
        }.alignment(.center)
            .spacing(.small)
    }
}

public extension FontIcon {
    enum Kit {
        public static let `close` = FontIcon(name: "Times", unicode: "\u{00D7}", font: .systemFont(ofSize: 24))
        public static let `back` = FontIcon(name: "Back", unicode: "\u{2190}", font: .systemFont(ofSize: 24))
        public static let `triangle` = FontIcon(name: "Triangle", unicode: "\u{0394}", font: .systemFont(ofSize: 24))
    }
}
