import Foundation
import UIKit

public extension DeclarativeView {
    @discardableResult
    func padding(_ padding: Padding) -> ContainerView {
        ContainerView { self }
            .padding(padding)
    }
}

public extension DeclarativeView where RootView: BaseStackView {
    @discardableResult
    func padding(_ padding: Padding) -> Self {
        rootView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding.top,
                                                                    leading: padding.leading,
                                                                    bottom: padding.bottom,
                                                                    trailing: padding.trailing)
        rootView.isLayoutMarginsRelativeArrangement = true
        return self
    }
}

public extension DeclarativeView where Self: ContainerView {
    @discardableResult
    func padding(_ padding: Padding) -> Self {
        top(padding.top)
        leading(padding.leading)
        bottom(padding.bottom)
        trailing(padding.trailing)
        rootView.setNeedsLayout()
        return self
    }
}

public extension DeclarativeComponent where View: ContainerView {
    @discardableResult
    func padding(_ padding: Padding) -> Self {
        view.padding(padding)
        return self
    }
}
