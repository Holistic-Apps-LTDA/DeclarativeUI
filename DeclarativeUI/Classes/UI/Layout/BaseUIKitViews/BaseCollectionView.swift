import UIKit

public class BaseCollectionView: UICollectionView, ObservableView {
    public var disposeBag = DisposeBag()
    public let events = Events()
    public var contentSizeStyle: ContentSizeStyle = .default {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    init(layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .white
        clipsToBounds = false
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseCollectionView {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseCollectionView>()
        public let didMoveToSuperview = Publisher<BaseCollectionView>()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        events.didLayoutSubviews.publish(self)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        events.didMoveToSuperview.publish(self)
    }
}

// MARK: Content Size

public extension BaseCollectionView {
    enum ContentSizeStyle {
        case `default`
        case content
    }

    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        switch contentSizeStyle {
        case .default:
            return super.intrinsicContentSize
        case .content:
            layoutIfNeeded()
            return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
        }
    }
}
