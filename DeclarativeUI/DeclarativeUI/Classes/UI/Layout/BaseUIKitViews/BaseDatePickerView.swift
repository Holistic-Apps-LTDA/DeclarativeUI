import UIKit

public class BaseDatePickerView: UIDatePicker, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseDatePickerView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseDatePickerView>()
        public let didMoveToSuperview = Publisher<BaseDatePickerView>()
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
