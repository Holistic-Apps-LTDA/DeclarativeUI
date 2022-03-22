import UIKit

public class DeclarativeTransition: NSObject {
    
    // MARK: Properties
    
    public var duration: AnimationDuration
    public var transitionType: TransitionType
    public var isDismissing = false
    
    // MARK: Life Cycle
    
    public init(type: TransitionType = .default, duration: AnimationDuration = .transition) {
        self.transitionType = type
        self.duration = duration
    }
    
    // MARK: Private Functions
    
    private func normalTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        toView.frame.size = containerView.frame.size
        containerView.addSubview(toView)
        toView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        transitionContext.completeTransition(true)
    }
    
    private func fadeInTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        toView.alpha = 0
        toView.frame.size = containerView.frame.size
        containerView.addSubview(toView)
        toView.animation.fade(.in, duration: duration) {
            transitionContext.completeTransition(true)
        }
    }
    
    private func fadeOutTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from) else { return }
            
        if let toView = transitionContext.view(forKey: .to) {
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
        }
        
        fromView.animation.fade(.out, duration: duration) {
            transitionContext.completeTransition(true)
            fromView.removeFromSuperview()
        }
    }
    
    private func slideInTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
   
        toView.frame.size = containerView.frame.size
        containerView.addSubview(toView)
        toView.frame.origin = CGPoint(x: toView.frame.width, y: 0)
        toView.animation.slide(.in, duration: duration) {
            transitionContext.completeTransition(true)
        }
    }
    
    private func slideOutTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from) else { return }
            
        if let toView = transitionContext.view(forKey: .to) {
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
        }
        
        fromView.animation.slide(.out, duration: duration) {
            transitionContext.completeTransition(true)
            fromView.removeFromSuperview()
        }
    }
    
    private func slideUpTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
   
        toView.frame.size = containerView.frame.size
        containerView.addSubview(toView)
        toView.frame.origin = CGPoint(x: 0, y: toView.frame.height)
        toView.animation.slide(.up, duration: duration) {
            transitionContext.completeTransition(true)
        }
    }
    
    private func slideDownTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from) else { return }
            
        if let toView = transitionContext.view(forKey: .to) {
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
        }
        
        fromView.animation.slide(.down, duration: duration) {
            transitionContext.completeTransition(true)
            fromView.removeFromSuperview()
        }
    }
}

// MARK: - Transition Type

public enum TransitionType {
    case fade, slide, slideUp, `default`
}

// MARK: - UIViewControllerAnimatedTransitioning

extension DeclarativeTransition: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration.value
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionType {
        case .fade:
            isDismissing ? fadeOutTransition(transitionContext) : fadeInTransition(transitionContext)
        case .slide:
            isDismissing ? slideOutTransition(transitionContext) : slideInTransition(transitionContext)
        case .slideUp:
            isDismissing ? slideDownTransition(transitionContext) : slideUpTransition(transitionContext)
        case .`default`:
            normalTransition(transitionContext)
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension DeclarativeTransition: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isDismissing = false
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isDismissing = true
        return self
    }
}
