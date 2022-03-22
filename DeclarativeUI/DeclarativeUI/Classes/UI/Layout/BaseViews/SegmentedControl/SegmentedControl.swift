import UIKit

public class SegmentedControl: DeclarativeView {
    public var rootView: BaseSegmentedControl { segmentedControl }
    private let segmentedControl = BaseSegmentedControl()
    private let delegate = Delegate()
    private let selectedColor: Color
    private let normalColor: Color
    
    public init(_ items: [String],
                selectedColor: Color = .black,
                normalColor: Color = .white) {
        self.selectedColor = selectedColor
        self.normalColor = normalColor
        setupSegmentControl(items: items)
        segmentedControl.addTarget(self, action: #selector(changeValue), for:.valueChanged)
    }
        
    @discardableResult
    public func didChangeValue(_ action: @escaping (Int) -> Void) -> Self {
        observe(delegate.events.didChangeValue) { _, value in
            action(value)
        }
        return self
    }
}

private extension SegmentedControl {
    private func setupSegmentControl(items: [String]) {
        segmentedControl.setTitleTextAttributes(
            [
                .foregroundColor : normalColor.value
            ],
            for: .selected
        )

        segmentedControl.setTitleTextAttributes(
            [
                .foregroundColor : selectedColor.value
            ],
            for: .normal
        )

        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = selectedColor.value
            
        } else {
            segmentedControl.tintColor = selectedColor.value
        }
        
        segmentedControl.layer.borderWidth = 1
        segmentedControl.backgroundColor = .clear
        segmentedControl.layer.borderColor = selectedColor.value.cgColor
                
        items.enumerated().forEach { (offset, element) in
            segmentedControl.insertSegment(withTitle: element, at: offset, animated: true)
        }
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc
    private func changeValue(_ sender: BaseSegmentedControl) {
        delegate.changeValue(sender: sender)
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        ViewContainer(view: segmentedControl)
            .previewDevice("iPhone 12")
    }

    static var segmentedControl = StackView(.vertical) {
        Spacer(.extraLarge3)
        SegmentedControl(["Opção 1", "Opção 2"])
    }.padding(.uniform(.extraLarge6))
        
}
