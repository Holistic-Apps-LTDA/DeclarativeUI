import UIKit

public class BaseStackView: UIStackView, ObservableView {
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

public extension BaseStackView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseStackView>()
        public let didMoveToSuperview = Publisher<BaseStackView>()
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
