import UIKit

public final class Spacer: DeclarativeView {
    private var spacerView = InvisibleView()
    public var rootView: BaseView { spacerView }
    
    public init(_ size: SpacerSize) {
        switch size {
        case .flexible:
            spacerView.setLayoutPriority(.zero)
        case .fixed(let size):
            spacerView.setLayoutPriority(.required)
            spacerView.layout.height(size.value).priority = .defaultLow
            spacerView.layout.width(size.value).priority = .defaultLow
        }
    }

    public convenience init(_ size: Size) {
        self.init(.fixed(size))
    }
}

public enum SpacerSize {
    case fixed(Size)
    case flexible
}
