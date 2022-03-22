import UIKit

extension PickerView {
    class DataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        let events = Events()
        var rows: [String] = []
        
        struct Events {
            var didSelectRow = Publisher<String>()
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return rows.count
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            guard rows.indices.contains(row) else { return }
            events.didSelectRow.publish(rows[row])
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return rows[row]
        }
    }
}
