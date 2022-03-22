import UIKit

public protocol UIViewConvertible: AnyObject, ViewGroup, LayoutAnchor {
    var uiView: UIView { get }
}

extension UIViewConvertible {
    public var views: [UIViewConvertible] { [self] }
}

extension UIView: UIViewConvertible {
    public var uiView: UIView { self }
}
