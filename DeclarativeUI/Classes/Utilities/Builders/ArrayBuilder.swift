import Foundation

@resultBuilder
public struct ArrayBuilder<Element> {
    public static func buildExpression(_ expression: Element) -> [Element] {
        [expression]
    }

    public static func buildExpression(_ expression: Element?) -> [Element] {
        expression.map({ [$0] }) ?? []
    }

    public static func buildBlock(_ children: [Element]...) -> [Element] {
        children.flatMap({ $0 })
    }

    public static func buildOptional(_ children: [Element]?) -> [Element] {
        children ?? []
    }

    public static func buildBlock(_ component: [Element]) -> [Element] {
        component
    }

    public static func buildEither(first child: [Element]) -> [Element] {
        child
    }

    public static func buildEither(second child: [Element]) -> [Element] {
        child
    }
}

public extension Array {
    init(@ArrayBuilder <Element> builder: () -> [Element]) {
        self = builder()
    }
}
