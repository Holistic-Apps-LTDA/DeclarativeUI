import UIKit

public class ZStackView: DeclarativeComponent {
    public private(set) var subviews = [UIViewConvertible]()
    public let view = EmptyView()

    public init(@UIViewBuilder _ views: () -> [UIViewConvertible]) {
        update(views)
    }
    
    @discardableResult
    public func update(@UIViewBuilder _ views: () -> [UIViewConvertible]) -> Self {
        subviews.forEach { $0.uiView.removeFromSuperview() }
        subviews = views()
        subviews.forEach { view in
            self.addView(view)
        }
        return self
    }
    
    @discardableResult
    public func addView(_ subview: UIViewConvertible) -> Self {
        view.layout.addSubview(subview)
        subview.layout.edgesToSuperview()
        return self
    }
}
