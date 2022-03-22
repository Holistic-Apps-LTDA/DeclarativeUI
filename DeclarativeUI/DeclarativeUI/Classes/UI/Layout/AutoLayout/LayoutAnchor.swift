import UIKit

public protocol LayoutAnchor {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

public extension UIViewConvertible {
    var leadingAnchor: NSLayoutXAxisAnchor { uiView.leadingAnchor }
    var trailingAnchor: NSLayoutXAxisAnchor { uiView.trailingAnchor }
    var leftAnchor: NSLayoutXAxisAnchor { uiView.leftAnchor }
    var rightAnchor: NSLayoutXAxisAnchor { uiView.rightAnchor }
    var topAnchor: NSLayoutYAxisAnchor { uiView.topAnchor }
    var bottomAnchor: NSLayoutYAxisAnchor { uiView.bottomAnchor }
    var widthAnchor: NSLayoutDimension { uiView.widthAnchor }
    var heightAnchor: NSLayoutDimension { uiView.heightAnchor }
    var centerXAnchor: NSLayoutXAxisAnchor { uiView.centerXAnchor }
    var centerYAnchor: NSLayoutYAxisAnchor { uiView.centerYAnchor }
}

extension UIView: LayoutAnchor {}
extension UILayoutGuide: LayoutAnchor {}
