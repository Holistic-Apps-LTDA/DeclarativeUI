import UIKit

public extension UIEdgeInsets {
    static func custom(top: CGFloat = .zero,
                       left: CGFloat = .zero,
                       bottom: CGFloat = .zero,
                       right: CGFloat = .zero) -> Self {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
    
    static func uniform(_ size: CGFloat) -> Self {
        custom(top: size, left: size, bottom: size, right: size)
    }
    
    static func horizontal(_ size: CGFloat) -> Self {
        custom(left: size, right: size)
    }

    static func vertical(_ size: CGFloat) -> Self {
        custom(top: size, bottom: size)
    }
    
    static func top(_ size: CGFloat) -> Self {
        custom(top: size)
    }

    static func left(_ size: CGFloat) -> Self {
        custom(left: size)
    }

    static func bottom(_ size: CGFloat) -> Self {
        custom(bottom: size)
    }

    static func right(_ size: CGFloat) -> Self {
        custom(right: size)
    }
}

public extension UIEdgeInsets {
    init(padding: Padding) {
        self.init(top: padding.top, left: padding.leading, bottom: padding.bottom, right: padding.trailing)
    }
    
    static func custom(top: Size = .zero,
                       left: Size = .zero,
                       bottom: Size = .zero,
                       right: Size = .zero) -> Self {
        self.init(top: top.value, left: left.value, bottom: bottom.value, right: right.value)
    }
    
    static func uniform(_ size: Size) -> Self {
        custom(top: size, left: size, bottom: size, right: size)
    }
    
    static func horizontal(_ size: Size) -> Self {
        custom(left: size, right: size)
    }

    static func vertical(_ size: Size) -> Self {
        custom(top: size, bottom: size)
    }
    
    static func top(_ size: Size) -> Self {
        custom(top: size)
    }

    static func left(_ size: Size) -> Self {
        custom(left: size)
    }

    static func bottom(_ size: Size) -> Self {
        custom(bottom: size)
    }

    static func right(_ size: Size) -> Self {
        custom(right: size)
    }
}

public func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
    return .init(top: lhs.top + rhs.top, left: lhs.left + rhs.left, bottom: lhs.bottom + rhs.bottom, right: lhs.right + rhs.right)
}
