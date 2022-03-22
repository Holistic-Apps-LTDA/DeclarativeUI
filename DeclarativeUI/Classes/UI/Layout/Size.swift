import Foundation
import UIKit

public struct Size: Hashable {
    
    public var value: CGFloat
    fileprivate init(_ value: CGFloat) {
        self.value = value
    }
        
    /// Height of view
    public static func height(of view: UIViewConvertible) -> Size {
        Size(view.uiView.frame.height)
    }
    
    /// Width of view
    public static func width(of view: UIViewConvertible) -> Size {
        Size(view.uiView.frame.width)
    }
}

public func + (lhs: Size, rhs: Size) -> Size {
    Size(lhs.value + rhs.value)
}

public extension Size {
    /// 0 pt
    static let zero = Size(0)
    /// 1 pt
    static let extraSmall4 = Size(1)
    /// 2 pt
    static let extraSmall3 = Size(2)
    /// 4 pt
    static let extraSmall2 = Size(4)
    /// 8 pt
    static let extraSmall = Size(8)
    /// 16 pt
    static let small = Size(16)
    /// 24 pt
    static let medium = Size(24)
    /// 32 pt
    static let large = Size(32)
    /// 40 pt
    static let extraLarge = Size(40)
    /// 48 pt
    static let extraLarge2 = Size(48)
    /// 56 pt
    static let extraLarge3 = Size(56)
    /// 64 pt
    static let extraLarge4 = Size(64)
    /// 80 pt
    static let extraLarge5 = Size(80)
    /// 88 pt
    static let extraLarge6 = Size(88)
    /// 96 pt
    static let extraLarge7 = Size(96)
    /// 120 pt
    static let extraLarge8 = Size(120)
}


