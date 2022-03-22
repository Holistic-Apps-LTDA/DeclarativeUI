import UIKit

public protocol AnimationManager {
    @discardableResult func animate(_ animation: @escaping () -> Void) -> Self
    @discardableResult func completion(_ completion: @escaping () -> Void) -> Self
    @discardableResult func then<T: AnimationManager>(_ next: T, delay: AnimationDuration) -> T
    func start(delay: AnimationDuration)
}
