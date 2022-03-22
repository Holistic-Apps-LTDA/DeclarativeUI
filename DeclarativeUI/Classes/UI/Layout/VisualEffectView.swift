import Foundation
import UIKit

public class VisualEffectView: DeclarativeView {
    public let rootView = BaseVisualEffectView()
    public init() {}
}

public extension VisualEffectView {
    @discardableResult
    func effect(_ effect: UIVisualEffect?) -> Self {
        rootView.effect = effect
        return self
    }
}
