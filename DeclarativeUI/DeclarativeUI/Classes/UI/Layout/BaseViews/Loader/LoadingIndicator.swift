//import UIKit
//
//public class LoadingIndicator: FlameView {
//    public var rootView: BaseView { view.rootView }
//    let view: AnimatedView
//    
//    public init(style: Style, size: Size) {
//        view = AnimatedView(animation: style.animation)
//            .loopMode(.loop)
//            .squared(size)
//    }
//}
//
//public extension LoadingIndicator {
//    struct Style: Hashable {
//        public let animation: Lottie.Animation
//        public static let dark = Style(animation: LottieAnimations.blueLoader)
//        public static let light = Style(animation: LottieAnimations.whiteLoader)
//    }
//}
//
//extension Lottie.Animation: Hashable {
//    public static func == (lhs: Animation, rhs: Animation) -> Bool {
//        lhs === rhs
//    }
//    
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(ObjectIdentifier(self))
//    }
//}
//
//public extension LoadingIndicator {
//    @discardableResult
//    func style(_ style: Style) -> Self {
//        view.animation(style.animation)
//        return self
//    }
//}
