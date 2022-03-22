import UIKit

public extension UIViewConvertible {
    func isVisible(in other: UIViewConvertible) -> Bool {
        let otherView = other.uiView
        let viewFrame = otherView.convert(uiView.bounds, from: uiView)
        return viewFrame.intersects(otherView.bounds)
    }
}

public func hide(@UIViewBuilder _ views: () -> [UIViewConvertible]) -> [UIViewConvertible] {
    views().map { view in
        view.uiView.isHidden = true
        return view
    }
}

public extension ViewGroup {
    @discardableResult
    func hidden(when value: Bool = true) -> Self {
        views.forEach { view in
            view.uiView.isHidden = value
        }
        return self
    }
}

public extension ViewGroup where Self: DeclarativeView {
    @discardableResult
    func hidden(when value: Publisher<Bool>) -> Self {
        rootView.observe(value) { view, value in
            view.hidden(when: value)
        }
        return self
    }
}

public extension ViewGroup {
    @discardableResult
    func alpha(_ value: CGFloat) -> Self {
        for view in views {
            view.uiView.alpha = value
        }
        return self
    }
}
