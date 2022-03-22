import UIKit

// MARK: Size

public extension Layout {
    @discardableResult
    func width(_ relation: Relation<LayoutAnchor>, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Constraint {
        activate {
            switch relation {
            case .equal(let anchor):
                return view.widthAnchor.constraint(equalTo: anchor.widthAnchor, multiplier: multiplier, constant: constant)
            case .smallerOrEqual(let anchor):
                return view.widthAnchor.constraint(lessThanOrEqualTo: anchor.widthAnchor, multiplier: multiplier, constant: constant)
            case .greaterOrEqual(let anchor):
                return view.widthAnchor.constraint(greaterThanOrEqualTo: anchor.widthAnchor, multiplier: multiplier, constant: constant)
            }
        }
    }
    
    @discardableResult
    func height(_ relation: Relation<CGFloat>) -> Constraint {
        activate {
            switch relation {
            case .equal(let value):
                return view.heightAnchor.constraint(equalToConstant: value)
            case .smallerOrEqual(let value):
                return view.heightAnchor.constraint(lessThanOrEqualToConstant: value)
            case .greaterOrEqual(let value):
                return view.heightAnchor.constraint(greaterThanOrEqualToConstant: value)
            }
        }
    }
    
    @discardableResult
    func height(_ relation: Relation<LayoutAnchor>, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Constraint {
        activate {
            switch relation {
            case .equal(let anchor):
                return view.heightAnchor.constraint(equalTo: anchor.heightAnchor, multiplier: multiplier, constant: constant)
            case .smallerOrEqual(let anchor):
                return view.heightAnchor.constraint(lessThanOrEqualTo: anchor.heightAnchor, multiplier: multiplier, constant: constant)
            case .greaterOrEqual(let anchor):
                return view.heightAnchor.constraint(greaterThanOrEqualTo: anchor.heightAnchor, multiplier: multiplier, constant: constant)
            }
        }
    }

    @discardableResult
    func width(_ relation: Relation<CGFloat>) -> Constraint {
        activate {
            switch relation {
            case .equal(let value):
                return view.widthAnchor.constraint(equalToConstant: value)
            case .smallerOrEqual(let value):
                return view.widthAnchor.constraint(lessThanOrEqualToConstant: value)
            case .greaterOrEqual(let value):
                return view.widthAnchor.constraint(greaterThanOrEqualToConstant: value)
            }
        }
    }
}

// MARK: Edges

public extension Layout {
    @discardableResult
    func top(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Constraint {
        activate {
            view.topAnchor.constraint(equalTo: anchor, constant: constant)
        }
    }

    @discardableResult
    func bottom(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Constraint {
        activate {
            view.bottomAnchor.constraint(equalTo: anchor, constant: -constant)
        }
    }
    
    @discardableResult
    func leading(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Constraint {
        activate {
            view.leadingAnchor.constraint(equalTo: anchor, constant: constant)
        }
    }
    
    @discardableResult
    func trailing(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Constraint {
        activate {
            view.trailingAnchor.constraint(equalTo: anchor, constant: -constant)
        }
    }
}

// MARK: Centering

public extension Layout {
    @discardableResult
    func centerHorizontally(in anchor: LayoutAnchor, constant: CGFloat = 0) -> Constraint {
        activate {
            view.centerXAnchor.constraint(equalTo: anchor.centerXAnchor, constant: constant)
        }
    }
    
    @discardableResult
    func centerVertically(in anchor: LayoutAnchor, constant: CGFloat = 0) -> Constraint {
        activate {
            view.centerYAnchor.constraint(equalTo: anchor.centerYAnchor, constant: constant)
        }
    }
}

// MARK: Aspect

public extension Layout {
    @discardableResult
    func aspectRatio(_ ratio: CGFloat = 1) -> Constraint {
        activate {
            view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: ratio)
        }
    }
}
