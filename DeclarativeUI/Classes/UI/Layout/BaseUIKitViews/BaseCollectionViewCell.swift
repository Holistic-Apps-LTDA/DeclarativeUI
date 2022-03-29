import UIKit

public class BaseCollectionViewCell: UICollectionViewCell, ObservableView {
    public static let reuseIdentifier = "BaseCollectionViewCell"
    public var disposeBag = DisposeBag()
    public let events = Events()
    private let stackView: StackView = .init(.vertical)

    override public init(frame: CGRect) {
        super.init(frame: frame)
        layout.addSubview(stackView)
        stackView.layout.edgesToSuperview()
    }
    
    public func update(with views: [UIViewConvertible]) {
        stackView.update {
            views
        }
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }
}

public extension BaseCollectionViewCell {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseCollectionViewCell>()
        public let didMoveToSuperview = Publisher<BaseCollectionViewCell>()
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
