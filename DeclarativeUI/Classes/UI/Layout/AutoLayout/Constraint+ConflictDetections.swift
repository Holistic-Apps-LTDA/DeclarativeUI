import UIKit

public extension Constraint {
    func conflictsWith(_ constraint: Constraint) -> Bool {
        guard firstAttribute == constraint.firstAttribute else { return false }
        guard secondAttribute == constraint.secondAttribute else { return false }
        guard relation == constraint.relation else { return false }
        guard priority == constraint.priority else { return false }
        guard firstItem === constraint.firstItem else { return false }
        guard secondItem === constraint.secondItem else { return false }
        return true
    }
}
