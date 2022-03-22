import UIKit

public class ScrollView: DeclarativeView {
    public let subview: UIViewConvertible
    public let scrollView = BaseScrollView()
    private let delegate = Delegate()
    private lazy var refreshControl = UIRefreshControl()
    private var action: (() -> Void)?
    public var rootView: BaseScrollView { scrollView }
    private lazy var topView = configure(EmptyView()) { view in
        scrollView.layout.addSubview(view)
        view.layout.bottomToTop(of: scrollView)
        view.layout.width(.equal(scrollView))
        view.layout.height(.equal(scrollView))
    }
    
    public init(_ axis: Constraint.Axis = .vertical,
                viewBuilder: () -> UIViewConvertible) {
        subview = viewBuilder()
        scrollView.delegate = delegate
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.layout.addSubview(subview)
        subview.layout.edges(to: scrollView.contentLayoutGuide)
        
        switch axis {
        case .vertical:
            subview.layout.width(.equal(scrollView))
            subview.layout.height(.greaterOrEqual(scrollView))
        case .horizontal:
            subview.layout.height(.equal(scrollView))
            subview.layout.width(.greaterOrEqual(scrollView))
        @unknown default:
            fatalError("Unknown value for ScrollView axis: \(axis)")
        }
    }
    
    @discardableResult
    public func topBounceColor(_ color: Color) -> Self {
        topView.backgroundColor(color)
        return self
    }
    
    @discardableResult
    public func didScroll(_ handler: @escaping (ScrollView) -> Void) -> Self {
        observe(delegate.events.didScroll) { scrollView, _ in
            handler(scrollView)
        }
        return self
    }
    
    @discardableResult
    public func refresh(_ action: @escaping () -> Void) -> Self {
        scrollView.refreshControl = refreshControl
        self.action = action
        scrollView.refreshControl?.addTarget(self, action: #selector(refreshAction),
                                             for: .valueChanged)
        return self
    }

    @discardableResult
    public func contentOffset(_ contentOffset: CGPoint) -> Self {
        scrollView.contentOffset = contentOffset
        return self
    }
    
    @discardableResult
    public func contentInset(_ contentInset: UIEdgeInsets) -> Self {
        scrollView.contentInset = contentInset
        return self
    }
    
    public func contentInset() -> UIEdgeInsets {
        scrollView.contentInset
    }
}

private extension ScrollView {
    @objc func refreshAction() {
        action?()
        scrollView.refreshControl?.endRefreshing()
    }
}
