import UIKit

public class BaseTableView: UITableView, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    init() {
        super.init(frame: .zero, style: .plain)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseTableView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseTableView>()
        public let didMoveToSuperview = Publisher<BaseTableView>()
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
