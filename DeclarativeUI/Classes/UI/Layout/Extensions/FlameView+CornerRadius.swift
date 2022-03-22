import Foundation
import UIKit

public extension DeclarativeView {
    @discardableResult
    func rounded() -> Self {
        rootView.observe(rootView.events.didLayoutSubviews) { view in
            view.cornerRadius(view.frame.height / 2)
        }
        return self
    }
    
    @discardableResult
    func cornerRadius(_ radius: Size) -> Self {
        cornerRadius(radius.value)
        return self
    }
    
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        rootView.clipsToBounds = true
        rootView.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func topCornerRadius(_ radius: Size) -> Self {
        rootView.observe(rootView.events.didLayoutSubviews) { view in
            let maskPath = UIBezierPath(roundedRect: view.bounds,
                                        byRoundingCorners: [.topLeft, .topRight],
                                        cornerRadii: CGSize(width: radius.value, height: radius.value))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = view.bounds
            maskLayer.path = maskPath.cgPath
            view.layer.mask = maskLayer
        }
        return self
    }
}

public extension DeclarativeView where RootView: BaseStackView {
    @discardableResult
    func rounded() -> ContainerView {
        ContainerView { self }
            .rounded()
    }
    
    @discardableResult
    func cornerRadius(_ radius: Size) -> ContainerView {
        ContainerView { self }
            .cornerRadius(radius)
    }
    
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> ContainerView {
        ContainerView { self }
            .cornerRadius(radius)
    }
}
