import UIKit

public protocol UIViewControllerConvertible: AnyObject {
    var uiViewController: UIViewController { get }
}

extension UIViewController: UIViewControllerConvertible {
    public var uiViewController: UIViewController { self }
}
