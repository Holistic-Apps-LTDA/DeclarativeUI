import UIKit

public protocol ObservableView: UIView, DeclarativeView {
    associatedtype Events: UIViewEvents
    var events: Events { get }
}

public protocol UIViewEvents {
    associatedtype View: ObservableView
    var didLayoutSubviews: Publisher<View> { get }
    var didMoveToSuperview: Publisher<View> { get }
}

public extension ObservableView {
    var rootView: Self { self }
}
