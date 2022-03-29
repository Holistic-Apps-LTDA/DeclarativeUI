import UIKit

public class BaseTableViewCell: UITableViewCell, ObservableView {
    public static let reuseIdentifier = "BaseTableViewCell"
    public var disposeBag = DisposeBag()
    public let events = Events()
    private let stackView: StackView = .init(.horizontal)

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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

public extension BaseTableViewCell {
    class Events: UIViewEvents {
        public let didLayoutSubviews = Publisher<BaseTableViewCell>()
        public let didMoveToSuperview = Publisher<BaseTableViewCell>()
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
