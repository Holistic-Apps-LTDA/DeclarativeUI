import UIKit

public extension Layout {
    func edges(to anchor: LayoutAnchor, insets: UIEdgeInsets = .zero) {
        vertical(to: anchor, top: insets.top, bottom: insets.bottom)
        horizontal(to: anchor, leading: insets.left, trailing: insets.right)
    }
    
    func center(in anchor: LayoutAnchor) {
        centerHorizontally(in: anchor)
        centerVertically(in: anchor)
    }
    
    func horizontal(to anchor: LayoutAnchor, leading: CGFloat = 0, trailing: CGFloat = 0) {
        self.leading(to: anchor.leadingAnchor, constant: leading)
        self.trailing(to: anchor.trailingAnchor, constant: trailing)
    }
    
    func vertical(to anchor: LayoutAnchor, top: CGFloat = 0, bottom: CGFloat = 0) {
        topToTop(of: anchor, constant: top)
        bottomToBottom(of: anchor, constant: bottom)
    }
    
    @discardableResult
    func height(_ value: CGFloat) -> Constraint {
        height(.equal(value))
    }
    
    @discardableResult
    func width(_ value: CGFloat) -> Constraint {
        width(.equal(value))
    }
    
    func size(_ relation: Relation<LayoutAnchor>, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        width(relation, multiplier: multiplier, constant: constant)
        height(relation, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func topToTop(of anchor: LayoutAnchor, constant: CGFloat = 0) -> Constraint {
        top(to: anchor.topAnchor, constant: constant)
    }
    
    @discardableResult
    func topToBottom(of anchor: LayoutAnchor, constant: CGFloat = 0) -> Constraint {
        top(to: anchor.bottomAnchor, constant: constant)
    }
    
    @discardableResult
    func bottomToTop(of anchor: LayoutAnchor, constant: CGFloat = 0) -> Constraint {
        bottom(to: anchor.topAnchor, constant: constant)
    }
    
    @discardableResult
    func bottomToBottom(of anchor: LayoutAnchor, constant: CGFloat = 0) -> Constraint {
        bottom(to: anchor.bottomAnchor, constant: constant)
    }
}
