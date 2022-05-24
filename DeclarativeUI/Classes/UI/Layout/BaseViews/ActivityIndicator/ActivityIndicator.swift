import UIKit

public class ActivityIndicator: DeclarativeView {
    private let activityIndicator = BaseActivityIndicator()
    public var rootView: BaseActivityIndicator { activityIndicator }

    public init(style: UIActivityIndicatorView.Style = .whiteLarge,
                hidesWhenStopped: Bool = true,
                startAnimating: Bool = true) {
        activityIndicator.style = style
        activityIndicator.hidesWhenStopped = hidesWhenStopped
        if startAnimating {
            activityIndicator.startAnimating()
        }
    }
    
    @discardableResult
    public func hidesWhenStopped(_ value: Bool) -> Self {
        activityIndicator.hidesWhenStopped = value
        return self
    }
    
    @discardableResult
    public func color(_ color: Color) -> Self {
        activityIndicator.color = color.value
        return self
    }

    public func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    public func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    @discardableResult
    public func animate(_ observable: Observable<Bool>) -> Self {
        observable.subscribe()
            .onNext { [weak self] value in
                guard let self = self else { return }
                if value {
                    self.startAnimating()
                } else {
                    self.stopAnimating()
                }
            }
            .disposedBy(self)
        return self
    }
}
