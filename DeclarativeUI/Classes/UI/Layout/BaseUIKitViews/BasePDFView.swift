import PDFKit

public class BasePDFView: PDFView, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BasePDFView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BasePDFView>()
        public let didMoveToSuperview = Publisher<BasePDFView>()
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
