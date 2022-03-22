import UIKit

public struct AccessibilityConfiguration {
    let identifier: String
    let label: String
    let hint: String
    let value: String
    let traits: UIAccessibilityTraits
    let adjustsContentSizeCategory: Bool
    
    public init(identifier: String = "", label: String = "", hint: String = "", value: String = "", traits: UIAccessibilityTraits = .none, adjustsContentSizeCategory: Bool = false) {
        self.identifier = identifier
        self.label = label
        self.hint = hint
        self.value = value
        self.traits = traits
        self.adjustsContentSizeCategory = adjustsContentSizeCategory
    }
}
