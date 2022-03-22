import UIKit

public protocol ViewGroup {
    var views: [UIViewConvertible] { get }
}

extension UIView: ViewGroup {
    public var views: [UIViewConvertible] { [self] }
}

extension Array: ViewGroup where Element == UIViewConvertible {
    public var views: [UIViewConvertible] { self }
}

@resultBuilder
public struct UIViewBuilder {
    public static func buildBlock(_ components: ViewGroup...) -> [UIViewConvertible] {
        components.flatMap(\.views)
    }

    public static func buildArray(_ components: [ViewGroup]) -> [UIViewConvertible] {
        components.flatMap(\.views)
    }

    public static func buildOptional(_ component: [ViewGroup]?) -> [UIViewConvertible] {
        component?.flatMap(\.views) ?? []
    }
    
    public static func buildEither(first component: [ViewGroup]) -> [UIViewConvertible] {
        component.flatMap(\.views)
    }

    public static func buildEither(second component: [ViewGroup]) -> [UIViewConvertible] {
        component.flatMap(\.views)
    }
}

extension Optional: ViewGroup where Wrapped: UIViewConvertible {
    public var views: [UIViewConvertible] {
        switch self {
        case .none:
            return []
        case .some(let view):
            return [view]
        }
    }
}
