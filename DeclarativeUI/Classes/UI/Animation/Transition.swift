import UIKit

public class Transition<View: UIViewConvertible> {
    public init(view: View) {
        _view = view
    }
    
    private var _view: View
    var view: UIView { _view.uiView }
}

public extension UIViewConvertible {
    var transition: Transition<Self> { Transition(view: self) }
}

public extension Transition {
    func fade(duration: AnimationDuration = .default, action: (View) -> Void) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration.value
        view.layer.add(animation, forKey: CATransitionType.fade.rawValue)
        action(self._view)
    }
}
