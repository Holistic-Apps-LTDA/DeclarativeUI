import Foundation
import UIKit

internal extension DeclarativeView {
    /// Renders UIView for Snapshot testing
    /// - Returns: UIView form Snapshot
    func _render(backgroundColor: UIColor = .white) -> UIView {
        let view = padding(.uniform(.small))
            .backgroundColor(Color(value: backgroundColor))
        _ = ContainerView { view }
        return view.uiView
    }
}
