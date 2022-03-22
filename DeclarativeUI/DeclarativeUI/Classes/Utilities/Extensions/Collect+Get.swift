import Foundation

public extension Collection {
    func element(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
