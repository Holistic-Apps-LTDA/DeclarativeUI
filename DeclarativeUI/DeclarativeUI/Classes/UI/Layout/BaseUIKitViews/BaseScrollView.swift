import UIKit

public class BaseScrollView: UIScrollView, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseScrollView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseScrollView>()
        public let didMoveToSuperview = Publisher<BaseScrollView>()
        public let isDragging = Publisher<BaseScrollView>()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        events.didLayoutSubviews.publish(self)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        events.didMoveToSuperview.publish(self)
    }
    
    override var isDragging: Bool {
        events.isDragging.publish(self)
        return super.isDragging
    }
}
