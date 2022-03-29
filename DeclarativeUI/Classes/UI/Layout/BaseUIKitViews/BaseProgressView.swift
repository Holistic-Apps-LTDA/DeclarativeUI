import UIKit

public class BaseProgressView: UIProgressView, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseProgressView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseProgressView>()
        public let didMoveToSuperview = Publisher<BaseProgressView>()
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
