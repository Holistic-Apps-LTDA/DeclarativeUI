import UIKit

public class IconButton: DeclarativeComponent {
    public let view: Icon
    
    init(icon: FontIcon = .empty, size: Icon.Size = .medium, color: Color = .black) {
        view = Icon(icon, size: size, color: color)
            .alignment(.center)
            .squared(.greaterOrEqual(.extraLarge))
    }
    
    @discardableResult
    public func color(_ color: Color) -> Self {
        view.color(color)
        return self
    }
    
    @discardableResult
    public func icon(_ icon: FontIcon) -> Self {
        view.icon(icon)
        return self
    }
}
