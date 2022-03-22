import UIKit

public class SearchBar: DeclarativeView {
    private let searchBar = BaseSearchBar()
    public var rootView: BaseSearchBar { searchBar }
    public let delegate = Delegate()

    public init(searchBarStyle: UISearchBar.Style = .minimal) {
        searchBar.searchBarStyle = searchBarStyle
        searchBar.delegate = delegate
    }
    
    public func text() -> String {
        return searchBar.text ?? ""
    }
    
    @discardableResult
    public func endEditing(_ value: Bool) -> Self {
        searchBar.endEditing(value)
        return self
    }

    @discardableResult
    public func placeholder(_ value: String) -> Self {
        searchBar.placeholder = value
        return self
    }

    @discardableResult
    public func shouldReturn(_ action: @escaping (SearchBar) -> Void) -> Self {
        observe(delegate.events.didShouldReturn) { view, _ in
            action(view)
        }
        return self
    }

    @discardableResult
    public func changeEditing(_ action: @escaping (SearchBar) -> Void) -> Self {
        observe(delegate.events.didChangeEditing) { view, searchBar in
            action(view)
        }
        return self
    }

    @discardableResult
    public func beginEditing(_ action: @escaping (SearchBar) -> Void) -> Self {
        observe(delegate.events.didBeginEditing) { view, _ in
            action(view)
        }
        return self
    }

    @discardableResult
    public func endEditing(_ action: @escaping (SearchBar) -> Void) -> Self {
        observe(delegate.events.didEndEditing) { view, _ in
            action(view)
        }
        return self
    }

}

import SwiftUI
@available(iOS 13.0.0, *)
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI.Group {
            ViewContainer(view: view)
                .previewDevice("iPhone 12")
        }
    }
    
    static var view = StackView(.vertical) {
        SearchBar()
        .placeholder("Placeholder")
        .changeEditing { text in
            print(text)
        }
        .padding(.uniform(.small))
    }
}
