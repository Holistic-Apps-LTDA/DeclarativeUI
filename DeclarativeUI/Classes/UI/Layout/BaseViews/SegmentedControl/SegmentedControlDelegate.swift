import UIKit

extension SegmentedControl {
    class Delegate: NSObject {
        let events = Events()
        
        struct Events {
            var didChangeValue = Publisher<Int>()
        }
        
        func changeValue(sender: BaseSegmentedControl) {
            events.didChangeValue.publish(sender.selectedSegmentIndex)
        }
    }
}
