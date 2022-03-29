import UIKit

extension ScrollView {
    class Delegate: NSObject, UIScrollViewDelegate {
        let events = ScrollViewEvents()
        struct ScrollViewEvents {
            let didScroll = Publisher<UIScrollView>()
        }

        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            events.didScroll.publish(scrollView)
        }
    }
}
