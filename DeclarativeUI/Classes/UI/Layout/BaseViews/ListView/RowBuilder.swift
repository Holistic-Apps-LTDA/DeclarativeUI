import UIKit

public protocol RowGroup {
    var rows: [Row] { get }
}

extension Row: RowGroup {
    public var rows: [Row] { [self] }
}

extension Array: RowGroup where Element == Row {
    public var rows: [Row] { self }
}

@resultBuilder
public struct RowBuilder {
    public static func buildBlock(_ components: RowGroup...) -> [Row] {
        components.flatMap(\.rows)
    }

    public static func buildArray(_ components: [RowGroup]) -> [Row] {
        components.flatMap(\.rows)
    }

    public static func buildOptional(_ component: [RowGroup]?) -> [Row] {
        component?.flatMap(\.rows) ?? []
    }
    
    public static func buildEither(first component: [RowGroup]) -> [Row] {
        component.flatMap(\.rows)
    }

    public static func buildEither(second component: [RowGroup]) -> [Row] {
        component.flatMap(\.rows)
    }
}
