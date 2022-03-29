import UIKit

// A view that doesn't draw on the screen
class InvisibleView: BaseView {
    var contentSize: CGSize? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    func setLayoutPriority(_ priority: UILayoutPriority) {
        setContentHuggingPriority(priority, for: .vertical)
        setContentHuggingPriority(priority, for: .horizontal)
        setContentCompressionResistancePriority(priority, for: .horizontal)
        setContentCompressionResistancePriority(priority, for: .vertical)
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize ?? super.intrinsicContentSize
    }
    
    override func draw(_ rect: CGRect) {}
    override func draw(_ layer: CALayer, in ctx: CGContext) {}
    override func draw(_ rect: CGRect, for formatter: UIViewPrintFormatter) {}
}
