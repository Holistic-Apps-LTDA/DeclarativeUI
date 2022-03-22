import UIKit

public extension Layout {
    enum Relation<Element> {
        case equal(Element)
        case smallerOrEqual(Element)
        case greaterOrEqual(Element)
        
        func map<T>(_ transform: (Element) -> T) -> Relation<T> {
            switch self {
            case .equal(let value):
                return .equal(transform(value))
            case .smallerOrEqual(let value):
                return .smallerOrEqual(transform(value))
            case .greaterOrEqual(let value):
                return .greaterOrEqual(transform(value))
            }
        }
    }
}

extension Layout.Relation: Equatable where Element: Equatable {}
extension Layout.Relation: Hashable where Element: Hashable {}
