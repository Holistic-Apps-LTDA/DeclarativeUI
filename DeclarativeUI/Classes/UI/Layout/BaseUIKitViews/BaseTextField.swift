import UIKit

public class BaseTextField: UITextField, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()

    init() {
        super.init(frame: .zero)
        setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
        
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        .zero
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseTextField {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseTextField>()
        public let didMoveToSuperview = Publisher<BaseTextField>()
        public let deleteBackward = Publisher<BaseTextField>()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        events.didLayoutSubviews.publish(self)
    }
    
     override func didMoveToSuperview() {
        super.didMoveToSuperview()
        events.didMoveToSuperview.publish(self)
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        events.deleteBackward.publish(self)
    }
}
