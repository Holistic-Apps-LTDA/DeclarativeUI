import UIKit

public class Animator: AnimationManager {
    public static var PropertyAnimator: UIViewPropertyAnimator.Type = UIViewPropertyAnimator.self
    private var duration: AnimationDuration = .default
    private var curve: UIView.AnimationCurve = .linear
    private var animations = [() -> Void]()
    private var completions = [() -> Void]()
    
    public init() {}
    
    @discardableResult
    public func duration(_ duration: AnimationDuration) -> Self {
        self.duration = duration
        return self
    }

    @discardableResult
    public func animate(_ animation: @escaping () -> Void) -> Self {
        animations.append(animation)
        return self
    }

    @discardableResult
    public func completion(_ completion: @escaping () -> Void) -> Self {
        completions.append(completion)
        return self
    }
    
    public func start(delay: AnimationDuration = .zero) {
        let animator = Animator.PropertyAnimator.init(duration: duration.value, curve: curve)
        
        for animation in animations {
            animator.addAnimations(animation)
        }
        
        for completion in completions {
            animator.addCompletion { _ in completion() }
        }
        
        animator.startAnimation(afterDelay: delay.value)
    }
    
    @discardableResult
    public func then<T: AnimationManager>(_ next: T, delay: AnimationDuration) -> T {
        completion {
            next.start(delay: delay)
        }
        return next
    }
}
