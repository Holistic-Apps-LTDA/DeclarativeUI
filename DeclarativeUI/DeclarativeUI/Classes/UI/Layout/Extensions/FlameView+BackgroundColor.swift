import Foundation

public extension DeclarativeView {
    @discardableResult
    func backgroundColor(_ color: Color) -> Self {
        rootView.backgroundColor = color.value
        return self
    }
}

public extension DeclarativeView where RootView: BaseStackView {
    @discardableResult
    func backgroundColor(_ color: Color) -> ContainerView {
        ContainerView { self }
            .backgroundColor(color)
    }
}
