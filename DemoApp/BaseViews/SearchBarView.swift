import DeclarativeUI

class SearchBarView: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    lazy var view = StackView(.vertical) {
        Spacer(.small)
        SearchBar()
        .placeholder("Placeholder")
        .changeEditing { searchBar in
            print(searchBar.text())
        }
        .shouldReturn { searchBar in
            searchBar.endEditing(true)
        }
        .padding(.horizontal(.small))
        Spacer(.flexible)
    }
}
