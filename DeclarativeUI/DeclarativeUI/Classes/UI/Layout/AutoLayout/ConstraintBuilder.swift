import UIKit

public typealias Constraint = NSLayoutConstraint

public protocol LayoutGroup {
    var constraints: [Constraint] { get }
}

extension Constraint: LayoutGroup {
    public var constraints: [Constraint] { [self] }
}

extension Array: LayoutGroup where Element == Constraint {
    public var constraints: [Constraint] { self }
}

@resultBuilder
public struct ConstraintBuilder {
    public static func buildBlock(_ components: LayoutGroup...) -> [Constraint] {
        components.flatMap(\.constraints)
    }

    public static func buildArray(_ components: [LayoutGroup]) -> [Constraint] {
        components.flatMap(\.constraints)
    }

    public static func buildOptional(_ component: [LayoutGroup]?) -> [Constraint] {
        component?.flatMap(\.constraints) ?? []
    }
    
    public static func buildEither(first component: [LayoutGroup]) -> [Constraint] {
        component.flatMap(\.constraints)
    }

    public static func buildEither(second component: [LayoutGroup]) -> [Constraint] {
        component.flatMap(\.constraints)
    }
}
