import UIKit

public class ListView: DeclarativeView {
    typealias Cell = BaseTableViewCell
    public var rootView: BaseTableView { tableView }
    private let dataSource = DataSource()
    private let tableView = BaseTableView()
    private lazy var refreshControl = UIRefreshControl()
    private var action: (() -> Void)?

    private init() {
        tableView.register(Cell.self,
                           forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }

    public convenience init<Value>(_ observable: Observable<Value>, @RowBuilder _ rows: @escaping (Value) -> [Row]) {
        self.init()
        observable.subscribe()
            .onNext { [weak self] value in
                guard let self = self else { return }
                self.dataSource.rows = rows(value)
                self.tableView.reloadData()
            }
            .disposedBy(self)
    }

    public convenience init(@RowBuilder _ rows: () -> [Row]) {
        self.init()
        dataSource.rows = rows()
        tableView.reloadData()
    }
}

public extension ListView {
    @discardableResult
    func separatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
        tableView.separatorStyle = style
        return self
    }

    @discardableResult
    func refresh(_ action: @escaping () -> Void) -> Self {
        tableView.refreshControl = refreshControl
        self.action = action
        tableView.refreshControl?.addTarget(self, action: #selector(refreshAction),
                                             for: .valueChanged)
        return self
    }
}

private extension ListView {
    @objc func refreshAction() {
        action?()
        tableView.refreshControl?.endRefreshing()
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct ListView_Previews: PreviewProvider {
    @ObservableProperty static var rows = Array(repeating: "Alpaca", count: 20)
    static var previews: some View {
        ViewContainer(
            view: ListView {
                rows.map { value in
                    Label(text: value, style: .systemFont())
                        .padding(.uniform(.extraLarge))
                        .asRow()
                }
            }
        )
    }
}
