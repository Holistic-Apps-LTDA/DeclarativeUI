import UIKit

public class ViewAnimation {
    public init(view: UIViewConvertible) {
        _view = view
    }
    
    private var _view: UIViewConvertible
    var view: UIView { _view.uiView }
}

public extension UIViewConvertible {
    var animation: ViewAnimation {
        ViewAnimation(view: self)
    }
}

// MARK: Slide

public extension ViewAnimation {
    typealias SlideCompletion = () -> Void
    
    @discardableResult
    func slide(_ mode: SlideMode, duration: AnimationDuration = .default, completion: FadeCompletion? = nil) -> Self {
        switch mode {
        case .out:
            slideOut(duration: duration, completion: completion)
        case .in:
            slideIn(duration: duration, completion: completion)
        case .down:
            slideDown(duration: duration, completion: completion)
        case .up:
            slideUp(duration: duration, completion: completion)
        }
        return self
    }
    
    @discardableResult
    func slideIn(duration: AnimationDuration = .default, completion: SlideCompletion? = nil) -> Self {
        self.view.frame.origin = CGPoint(x: self.view.frame.width, y: 0)
        Animator()
            .duration(duration)
            .animate {
                self.view.frame.origin = CGPoint(x: 0, y: 0)
            }.completion {
                completion?()
            }.start()
        return self
    }
    
    @discardableResult
    func slideOut(duration: AnimationDuration = .default, completion: SlideCompletion? = nil) -> Self {
        Animator()
            .duration(duration)
            .animate {
                self.view.frame.origin = CGPoint(x: self.view.frame.width, y: 0)
            }.completion {
                completion?()
            }.start()
        return self
    }
    
    @discardableResult
    func slideUp(duration: AnimationDuration = .default, completion: SlideCompletion? = nil) -> Self {
        self.view.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
        Animator()
            .duration(duration)
            .animate {
                self.view.frame.origin = CGPoint(x: 0, y: 0)
            }.completion {
                completion?()
            }.start()
        return self
    }
    
    @discardableResult
    func slideDown(duration: AnimationDuration = .default, completion: SlideCompletion? = nil) -> Self {
        Animator()
            .duration(duration)
            .animate {
                self.view.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
            }.completion {
                completion?()
            }.start()
        return self
    }
}

public enum SlideMode {
    case `in`
    case out
    case up
    case down
}

// MARK: Fade

public extension ViewAnimation {
    typealias FadeCompletion = () -> Void

    @discardableResult
    func fade(_ mode: FadeMode, duration: AnimationDuration = .default, completion: FadeCompletion? = nil) -> Self {
        switch mode {
        case .out:
            fadeOut(duration: duration, completion: completion)
        case .in:
            fadeIn(duration: duration, completion: completion)
        }
        return self
    }

    @discardableResult
    func fadeIn(duration: AnimationDuration = .default, completion: FadeCompletion? = nil, shouldChangeVisibility: Bool = true) -> Self {
        if shouldChangeVisibility {
            view.hidden(when: false)
        }
        self.view.alpha(0)
        Animator()
            .duration(duration)
            .animate {
                self.view.alpha(1)
            }.completion {
                completion?()
            }.start()
        return self
    }

    @discardableResult
    func fadeOut(duration: AnimationDuration = .default, completion: FadeCompletion? = nil, shouldChangeVisibility: Bool = true) -> Self {
        Animator()
            .duration(duration)
            .animate {
                self.view.alpha(0)
            }.completion {
                if shouldChangeVisibility {
                    self.view.hidden()
                }
                completion?()
            }.start()
        return self
    }
}

public enum FadeMode {
    case `in`
    case out
        
    public static func show(when condition: Bool) -> Self {
        hide(when: !condition)
    }
        
    public static func hide(when condition: Bool) -> Self {
        switch condition {
        case true:
            return .out
        case false:
            return .in
        }
    }
}
