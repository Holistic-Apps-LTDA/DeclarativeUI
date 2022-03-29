import SwiftUI
import UIKit

public class ContainerView: DeclarativeComponent {
    public let subview: UIViewConvertible
    public let view = EmptyView()
    
    private let leading: Constraint
    private let trailing: Constraint
    private let top: Constraint
    private let bottom: Constraint
    private let centerVertically: Constraint
    private let centerHorizontally: Constraint
    private var constraints: [Constraint] {
        [
            leading,
            trailing,
            top,
            bottom,
            centerVertically,
            centerHorizontally,
        ]
    }
    
    public init(viewBuilder: () -> UIViewConvertible) {
        subview = viewBuilder()
        view.layout.addSubview(subview)
        
        leading = subview.layout.leadingToSuperview()
        trailing = subview.layout.trailingToSuperview()
        top = subview.layout.topToSuperview()
        bottom = subview.layout.bottomToSuperview()
        centerVertically = subview.layout.centerVerticallyInSuperview()
        centerHorizontally = subview.layout.centerHorizontallyInSuperview()
    }
    
    private func resetConstraints() {
        constraints.forEach { constraint in
            constraint.priority = .defaultLow
            constraint.isActive = true
        }
        
        if subview is Label {
            leading.priority = .required
            trailing.priority = .required
        }
    }
    
    @discardableResult
    public func alignment(_ value: Alignment) -> Self {
        resetConstraints()
        switch value {
        case .fill:
            constraints.forEach { $0.priority = .required }
        case .center:
            centerVertically.priority = .required
            centerHorizontally.priority = .required
        case .top:
            top.priority = .required
            centerHorizontally.priority = .required
        case .bottom:
            bottom.priority = .required
            centerHorizontally.priority = .required
        case .leading:
            leading.priority = .required
            centerVertically.priority = .required
        case .trailing:
            trailing.priority = .required
            centerVertically.priority = .required
        case .leadingTop:
            leading.priority = .required
            top.priority = .required
        case .leadingBottom:
            leading.priority = .required
            bottom.priority = .required
        case .trailingTop:
            trailing.priority = .required
            top.priority = .required
        case .trailingBottom:
            trailing.priority = .required
            bottom.priority = .required
        }
        return self
    }
    
    @discardableResult
    public func leading(_ constant: CGFloat) -> Self {
        leading.constant = constant
        return self
    }

    @discardableResult
    public func trailing(_ constant: CGFloat) -> Self {
        trailing.constant = -constant
        return self
    }

    @discardableResult
    public func top(_ constant: CGFloat) -> Self {
        top.constant = constant
        return self
    }

    @discardableResult
    public func bottom(_ constant: CGFloat) -> Self {
        bottom.constant = -constant
        return self
    }
}

public extension ContainerView {
    enum Alignment: String, CaseIterable {
        case fill
        case center
        case top
        case leading
        case bottom
        case trailing
        case leadingTop
        case leadingBottom
        case trailingTop
        case trailingBottom
    }
}

public extension DeclarativeComponent where View: ContainerView {
    @discardableResult
    func alignment(_ value: ContainerView.Alignment) -> Self {
        view.alignment(value)
        return self
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct Container_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI.Group {
            wrap(.fill)
            wrap(.center)
            wrap(.top)
            wrap(.leading)
            wrap(.bottom)
            wrap(.trailing)
            wrap(.leadingTop)
            wrap(.leadingBottom)
            wrap(.trailingTop)
            wrap(.trailingBottom)
        }
    }

    static var square: ContainerView {
        ContainerView {
            EmptyView()
                .backgroundColor(.white)
                .squared(.medium)
                .aspectRatio(1)
        }
    }
    
    static var labelSquare: ContainerView {
        ContainerView {
            Label(text: "Test label", style: .init(font: .systemFont(ofSize: 15), fontStyle: .init(kern: 15, lineHeight: 15, color: .black)))
                .backgroundColor(.black)
        }
    }
    
    static func wrap(_ alignment: ContainerView.Alignment) -> some View {
        let stack = StackView(.vertical) {
            Label(text: alignment.rawValue, style: .init(font: .systemFont(ofSize: 15), fontStyle: .init(kern: 15, lineHeight: 15, color: .black)))
                .alignment(.center)
            square.alignment(alignment)
                .backgroundColor(.black)
                .squared(.extraLarge7)
            labelSquare.alignment(alignment)
                .backgroundColor(.black)
                .squared(.extraLarge7)
        }.spacing(.small)
        
        return ViewContainer(view: stack)
            .previewLayout(.fixed(width: 150, height: 246))
    }
}
