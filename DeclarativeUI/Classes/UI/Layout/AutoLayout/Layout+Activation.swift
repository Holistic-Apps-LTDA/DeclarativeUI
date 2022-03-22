
import UIKit

public extension Layout {
    func activate(_ constraint: () -> Constraint) -> Constraint {
        activate(constraint())
    }
    
    @discardableResult
    func activate(_ constraint: Constraint) -> Constraint {
        removeConflictingConstraints(with: constraint)
        constraint.isActive = true
        return constraint
    }
    
    func removeConflictingConstraints(with newConstraint: Constraint) {
        let allConstraints = (newConstraint.firstItem?.constraints ?? []) + (newConstraint.secondItem?.constraints ?? [])
        for constraint in allConstraints {
            if constraint.conflictsWith(newConstraint) {
                constraint.isActive = false
            }
        }
    }
}
