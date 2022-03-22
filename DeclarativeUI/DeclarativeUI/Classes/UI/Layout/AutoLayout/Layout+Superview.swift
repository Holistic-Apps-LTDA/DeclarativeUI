import UIKit

public extension Layout {
    var superview: UIView {
        guard let superview = view.superview else { fatalError("Superview is not set: \(view)") }
        return superview
    }
    
    func edgesToSuperview(insets: UIEdgeInsets = .zero) {
        edges(to: superview, insets: insets)
    }
    
    @discardableResult
    func leadingToSuperview(constant: CGFloat = 0) -> Constraint {
        activate {
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant)
        }
    }
    
    @discardableResult
    func trailingToSuperview(constant: CGFloat = 0) -> Constraint {
        activate {
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant)
        }
    }
    
    @discardableResult
    func topToSuperview(constant: CGFloat = 0) -> Constraint {
        topToTop(of: superview, constant: constant)
    }
    
    @discardableResult
    func bottomToSuperview(constant: CGFloat = 0) -> Constraint {
        bottomToBottom(of: superview, constant: constant)
    }
    
    func centerInSuperview() {
        center(in: superview)
    }
    
    @discardableResult
    func centerHorizontallyInSuperview(constant: CGFloat = 0) -> Constraint {
        centerHorizontally(in: superview, constant: constant)
    }
    
    @discardableResult
    func centerVerticallyInSuperview(constant: CGFloat = 0) -> Constraint {
        centerVertically(in: superview, constant: constant)
    }
}
