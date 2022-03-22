import Foundation
import UIKit

public struct Padding: Hashable {
    let top: CGFloat
    let leading: CGFloat
    let bottom: CGFloat
    let trailing: CGFloat
    
    fileprivate init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
    
    public static func custom(top: Size = .zero,
                              leading: Size = .zero,
                              bottom: Size = .zero,
                              trailing: Size = .zero) -> Self {
        self.init(top: top.value,
                  leading: leading.value,
                  bottom: bottom.value,
                  trailing: trailing.value)
    }
    
    public static func uniform(_ size: Size) -> Self {
        custom(top: size, leading: size, bottom: size, trailing: size)
    }
    
    public static func horizontal(_ size: Size) -> Self {
        custom(leading: size, trailing: size)
    }

    public static func vertical(_ size: Size) -> Self {
        custom(top: size, bottom: size)
    }
    
    public static func top(_ size: Size) -> Self {
        custom(top: size)
    }

    public static func leading(_ size: Size) -> Self {
        custom(leading: size)
    }

    public static func bottom(_ size: Size) -> Self {
        custom(bottom: size)
    }

    public static func trailing(_ size: Size) -> Self {
        custom(trailing: size)
    }
}

public func + (lhs: Padding, rhs: Padding) -> Padding {
    Padding(top: lhs.top + rhs.top,
            leading: lhs.leading + rhs.leading,
            bottom: lhs.bottom + rhs.bottom,
            trailing: lhs.trailing + rhs.trailing)
}
