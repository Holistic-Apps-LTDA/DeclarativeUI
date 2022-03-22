import UIKit

public class BaseView: UIView, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseView>()
        public let didMoveToSuperview = Publisher<BaseView>()
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
