import UIKit

public class Layout {
    public init(view: UIViewConvertible) {
        _view = view
    }
    
    private var _view: UIViewConvertible
    public var view: UIView { _view.uiView }
}

public extension UIViewConvertible {
    var layout: Layout { Layout(view: self) }
}
