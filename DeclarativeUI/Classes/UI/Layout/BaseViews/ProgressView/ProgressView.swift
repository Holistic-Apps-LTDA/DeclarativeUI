public class ProgressView: DeclarativeView {
    public let rootView = BaseProgressView()
    private let progress = Progress()
    
    public enum Flow {
        case `default`
        case reverse
    }
    
    public init(progressTintColor: Color = .black) {
        rootView.observedProgress = progress
        rootView.progressTintColor = progressTintColor.value
    }
    
    @discardableResult
    public func style(_ progressViewStyle: UIProgressView.Style) -> Self {
        rootView.progressViewStyle = progressViewStyle
        return self
    }
    
    @discardableResult
    public func orientation(_ semanticContentAttribute: UISemanticContentAttribute) -> Self {
        rootView.semanticContentAttribute = semanticContentAttribute
        return self
    }
    
    @discardableResult
    public func inverse() -> Self {
        rootView.trackTintColor = Color.black.value
        rootView.progressTintColor = Color.black.value
        return self
    }
    
    @discardableResult
    public func progress(_ completed: Int, of total: Int) -> Self {
        progress.completedUnitCount = Int64(completed)
        progress.totalUnitCount = Int64(total)
        return self
    }
    
    @discardableResult
    public func progress(_ progress: Double, animated: Bool = true) -> Self {
        rootView.setProgress(Float(progress), animated: animated)
        return self
    }
    
    @discardableResult
    public func progress(_ progress: Publisher<Double>) -> Self {
        observe(progress) { `self`, progress in
            self.progress(progress)
        }
        return self
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI.Group {
            ForEach(0 ..< 7) { i in
                wrap(ProgressView().progress(i, of: 6))
            }
        }
    }

    static func wrap(_ view: UIViewConvertible) -> some View {
        ViewContainer(
            view: StackView(.vertical) {
                Spacer(.medium)
                view
                Spacer(.medium)
            }
        ).previewLayout(.fixed(width: 320, height: 56))
    }
}

// Keeping it private for a while
private extension DeclarativeView {
    var bounds: Publisher<CGRect> {
        rootView.events.didLayoutSubviews
            .map(\.bounds)
            .distinct()
    }
}
