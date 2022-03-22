import UIKit

public protocol DeclarativeView: UIViewConvertible, DisposeManager {
    associatedtype RootView: ObservableView
    var rootView: RootView { get }
}

extension DeclarativeView {
    public var uiView: UIView { rootView.uiView }
    public var disposeBag: DisposeBag { rootView.disposeBag }
}

public protocol DeclarativeComponent: DeclarativeView {
    associatedtype View: DeclarativeView
    var view: View { get }
}

extension DeclarativeComponent {
    public var rootView: View.RootView { view.rootView }
}


