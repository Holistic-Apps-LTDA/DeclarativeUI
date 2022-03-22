//import UIKit
//
//public class AnimatedView: FlameComponent {
//    public static var startingProgress: CGFloat = .zero
//    private let animationView = AnimationView()
//    public lazy var view = ContainerView {
//        animationView
//    }
//    
//    public init() {}
//    
//    public init(animation: Animation) {
//        self.animation(animation)
//    }
//}
//
//public extension AnimatedView {
//    @discardableResult
//    func animation(_ animation: Animation) -> Self {
//        animationView.animation = animation
//        play()
//        return self
//    }
//    
//    @discardableResult
//    func loopMode(_ loopMode: LottieLoopMode) -> Self {
//        animationView.loopMode = loopMode
//        return self
//    }
//    
//    @discardableResult
//    func play() -> Self {
//        animationView.currentProgress = AnimatedView.startingProgress
//        animationView.play()
//        return self
//    }
//    
//    @discardableResult
//    func stop() -> Self {
//        animationView.stop()
//        return self
//    }
//    
//}
