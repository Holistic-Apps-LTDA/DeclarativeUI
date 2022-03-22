import UIKit

public class Row {
    let view: () -> [UIViewConvertible]
    public init(@UIViewBuilder _ view: @escaping () -> [UIViewConvertible]) {
        self.view = view
    }
    
    // MARK: Tap

    private var onTapHandler: (() -> Void)?
    private var onDisplayHandler: (() -> Void)?
    private(set) public var hasTapAction: Bool = false
    @discardableResult
    public func onTap(_ action: @escaping () -> Void) -> Self {
        onTapHandler = action
        hasTapAction = true
        return self
    }
    
    public func runTap() {
        onTapHandler?()
    }
    
    @discardableResult
    public func onDisplay(_ action: @escaping () -> Void) -> Self {
        onDisplayHandler = action
        return self
    }
    
    public func runDisplay() {
        onDisplayHandler?()
    }
    
    @discardableResult
    public func enableInteraction() -> Self {
        hasTapAction = true
        return self
    }
}

public extension DeclarativeView {
    func asRow() -> Row {
        Row { self }
    }
}
