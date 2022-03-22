import UIKit

public protocol ViewModifier: Hashable, CustomStringConvertible {
    associatedtype View
    var modifierName: String { get }
    func apply(to: View)
}

public extension ViewModifier {
    var description: String {
        modifierName
    }
}
