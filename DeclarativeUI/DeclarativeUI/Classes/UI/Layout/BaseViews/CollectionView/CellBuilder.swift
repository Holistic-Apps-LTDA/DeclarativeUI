import UIKit

public protocol CellGroup {
    var cells: [Cell] { get }
}

extension Cell: CellGroup {
    public var cells: [Cell] { [self] }
}

extension Array: CellGroup where Element == Cell {
    public var cells: [Cell] { self }
}

@resultBuilder
public struct CellBuilder {
    public static func buildBlock(_ components: CellGroup...) -> [Cell] {
        components.flatMap(\.cells)
    }

    public static func buildArray(_ components: [CellGroup]) -> [Cell] {
        components.flatMap(\.cells)
    }

    public static func buildOptional(_ component: [CellGroup]?) -> [Cell] {
        component?.flatMap(\.cells) ?? []
    }
    
    public static func buildEither(first component: [CellGroup]) -> [Cell] {
        component.flatMap(\.cells)
    }

    public static func buildEither(second component: [CellGroup]) -> [Cell] {
        component.flatMap(\.cells)
    }
}
