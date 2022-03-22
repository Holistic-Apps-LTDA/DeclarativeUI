import UIKit

public class BarButtonItem: UIBarButtonItem {
    
    private var onTap: (() -> Void)?
    
    public init(icon: FontIcon, color: Color) {
        super.init()
        target = self
        action = #selector(runAction)
        tintColor = color.value
        image = Icon(icon, size: .large, color: color).asImage()
    }
    
    public init(customView: UIViewConvertible, color: Color = .white) {
        super.init()
        tintColor = color.value
        customView.uiView.addGestureRecognizer(TapGestureRecognizer())
        self.customView = customView.uiView
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
    
    @discardableResult
    public func onTap(_ action: @escaping () -> Void) -> Self {
        self.onTap = action
        return self
    }
}

private extension BarButtonItem {
    @objc func runAction() {
        onTap?()
    }
}
