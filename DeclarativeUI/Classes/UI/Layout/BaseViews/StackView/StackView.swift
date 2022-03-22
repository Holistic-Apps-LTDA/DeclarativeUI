import UIKit

public class StackView: DeclarativeView {
    public private(set) var subviews = [UIViewConvertible]()
    let stackView = BaseStackView()
    public var rootView: BaseStackView { stackView }
    
    public init(_ axis: Constraint.Axis = .vertical) {
        stackView.axis = axis
    }
    
    public convenience init(_ axis: Constraint.Axis = .vertical, @UIViewBuilder _ views: () -> [UIViewConvertible]) {
        self.init(axis)
        update(views)
    }
    
    @discardableResult
    public func update(@UIViewBuilder _ views: () -> [UIViewConvertible]) -> Self {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for view in views() {
            addArrangedSubview(view)
        }
        return self
    }
    
    @discardableResult
    public func addArrangedSubview(_ view: UIViewConvertible) -> Self {
        subviews.append(view)
        stackView.addArrangedSubview(view.uiView)
        return self
    }
    
    @discardableResult
    public func alignment(_ alignment: UIStackView.Alignment) -> Self {
        stackView.alignment = alignment
        return self
    }
    
    @discardableResult
    public func distribution(_ distribution: UIStackView.Distribution) -> Self {
        stackView.distribution = distribution
        return self
    }
    
    @discardableResult
    public func spacing(_ size: Size) -> Self {
        stackView.spacing = size.value
        return self
    }
    
    @discardableResult
    public func dismissKeboardWhenClicked() -> Self {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        stackView.addGestureRecognizer(tapGesture)
        return self
    }
    
    @objc private func endEditing() {
        stackView.endEditing(true)
    }
    
    @discardableResult
    public func axis(_ axis: Constraint.Axis) -> Self {
        stackView.axis = axis
        return self
    }
}
