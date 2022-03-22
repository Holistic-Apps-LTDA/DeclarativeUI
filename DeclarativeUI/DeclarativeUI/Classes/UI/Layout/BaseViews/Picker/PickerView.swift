import UIKit

public class PickerView: DeclarativeView {
    public var rootView: BasePickerView { picker }
    private let picker = BasePickerView()
    private let dataSource = DataSource()
    
    private init() {
        picker.dataSource = dataSource
        picker.delegate = dataSource
    }

    public convenience init(_ rows: () -> [String]) {
        self.init()
        dataSource.rows = rows()
        picker.reloadAllComponents()
    }
    
    public convenience init(_ observable: Observable<[String]>) {
        self.init()
        observable.subscribe()
            .onNext { [weak self] value in
                guard let self = self else { return }
                self.dataSource.rows = value
                self.picker.reloadAllComponents()
            }
            .disposedBy(self)
    }
    
    @discardableResult
    public func didSelectRow(_ action: @escaping (String) -> Void) -> Self {
        observe(dataSource.events.didSelectRow) { _, value in
            action(value)
        }
        return self
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct PickerView_Previews: PreviewProvider {
    @ObservableProperty static var rows = Array(repeating: "Opções", count: 40)
    static var previews: some View {
        ViewContainer(view: pickerView)
    }

    static var pickerView = PickerView {
        rows
    }
}
