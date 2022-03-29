import UIKit

public extension Layout {
    func addSubview(_ subview: UIViewConvertible) {
        let subview = subview.uiView
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubview(_ subview: UIViewConvertible, configuration: (Layout) -> Void) {
        addSubview(subview)
        configuration(subview.layout)
    }
}
