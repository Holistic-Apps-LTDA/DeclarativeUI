import UIKit
import WebKit

public class BaseWebKitView: WKWebView, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    
    init(configuration: WKWebViewConfiguration) {
        super.init(frame: .zero, configuration: configuration)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseWebKitView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseWebKitView>()
        public let didMoveToSuperview = Publisher<BaseWebKitView>()
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
