import UIKit

extension ListView {
    class DataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
        var rows: [Row] = []
        let events = ListViewEvents()
        
        struct ListViewEvents {
            let didScroll = Publisher<UIScrollView>()
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            rows[indexPath.row].runTap()
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            rows.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let row = rows[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
            cell.contentView.isUserInteractionEnabled =  !row.hasTapAction
            cell.update(with: row.view())
            return cell
        }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            rows[indexPath.row].runDisplay()
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            events.didScroll.publish(scrollView)
        }
    }
}
