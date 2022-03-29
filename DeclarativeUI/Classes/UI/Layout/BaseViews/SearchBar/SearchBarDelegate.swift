import UIKit

extension SearchBar {
    public class Delegate: NSObject, UISearchBarDelegate {
        internal let events = Events()
                        
        struct Events {
            var didBeginEditing = Publisher<UISearchBar>()
            var didEndEditing = Publisher<UISearchBar>()
            var didChangeEditing = Publisher<UISearchBar>()
            var didShouldReturn = Publisher<UISearchBar>()
        }
        
        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            events.didBeginEditing.publish(searchBar)
        }

        public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            events.didEndEditing.publish(searchBar)
        }
        
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            events.didChangeEditing.publish(searchBar)
        }
        
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            events.didShouldReturn.publish(searchBar)
        }
    }
}
