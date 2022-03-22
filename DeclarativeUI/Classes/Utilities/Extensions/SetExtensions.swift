import Foundation

public extension Set {
    func containsAny<S: Sequence>(of sequence: S) -> Bool where S.Element == Element {
        for element in sequence {
            if contains(element) {
                return true
            }
        }
        return false
    }
}
