import UIKit

extension TextField {
    public class Delegate: NSObject, UITextFieldDelegate {
        private let maxLength: Int?
        internal let events = Events()
        
        init(maxLength: Int? = nil) {
            self.maxLength = maxLength
        }
                
        struct Events {
            var didBeginEditing = Publisher<UITextField>()
            var didEndEditing = Publisher<UITextField>()
            var didChangeEditing = Publisher<UITextField>()
            var shouldChangeCharactersIn = Publisher<String>()
            var didShouldReturn = Publisher<UITextField>()
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            events.didBeginEditing.publish(textField)
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            events.didEndEditing.publish(textField)
        }
        
        public func didChangeEditing(_ textField: UITextField) {
            events.didChangeEditing.publish(textField)
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            events.didShouldReturn.publish(textField)
            return true
        }

        public func shouldChangeCharactersIn(_ textField: UITextField) -> Bool {
            return true
        }

        public func textField(
            _ textField: UITextField,
            shouldChangeCharactersIn range: NSRange,
            replacementString string: String
        ) -> Bool {
            guard maxLength != nil else { return true }
            guard let text = textField.text else { return false }
            let newLength = text.count + string.count - range.length
            if newLength > maxLength! {
                events.shouldChangeCharactersIn.publish(string)
                return false
            } else {
                events.shouldChangeCharactersIn.publish(string)
                return true
            }
        }

    }
}
