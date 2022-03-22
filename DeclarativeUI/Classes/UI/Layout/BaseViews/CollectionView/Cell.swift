import UIKit

public class Cell {
    let view: () -> [UIViewConvertible]
    public init(@UIViewBuilder _ view: @escaping () -> [UIViewConvertible]) {
        self.view = view
    }
    
    // MARK: Tap

    var onTapHandler: (() -> Void)?
    @discardableResult
    public func onTap(_ action: @escaping () -> Void) -> Self {
        onTapHandler = action
        return self
    }
    
    public func runTap() {
        onTapHandler?()
    }
}

public extension DeclarativeView {
    func asCell() -> Cell {
        Cell { self }
    }
}
