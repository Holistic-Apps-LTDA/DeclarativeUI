import UIKit

public class BaseActivityIndicator: UIActivityIndicatorView, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    public required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

public extension BaseActivityIndicator {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseActivityIndicator>()
        public let didMoveToSuperview = Publisher<BaseActivityIndicator>()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        events.didLayoutSubviews.publish(self)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        events.didMoveToSuperview.publish(self)
    }
}
