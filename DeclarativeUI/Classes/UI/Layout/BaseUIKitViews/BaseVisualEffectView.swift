import UIKit

public class BaseVisualEffectView: UIVisualEffectView, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    init() {
        super.init(effect: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseVisualEffectView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseVisualEffectView>()
        public let didMoveToSuperview = Publisher<BaseVisualEffectView>()
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
