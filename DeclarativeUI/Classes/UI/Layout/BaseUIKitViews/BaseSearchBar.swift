import UIKit

public class BaseSearchBar: UISearchBar, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()

    init() {
        super.init(frame: .zero)
        setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
            
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseSearchBar {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseSearchBar>()
        public let didMoveToSuperview = Publisher<BaseSearchBar>()
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
