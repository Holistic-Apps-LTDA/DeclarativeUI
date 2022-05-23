import DeclarativeUI

class BaseViews: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    lazy var view = ListView {
        row(title: "SearchBar") { [weak self] in
            guard let self = self else { return }
            let viewController = SearchBarView(navigator: self.navigator)
                .navigationTitle("Search Bar")
            self.navigator.push(viewController)
        }
        
        row(title: "WebView") { [weak self] in
            guard let self = self else { return }
            let viewController = WebViewController()
                .navigationTitle("Web View")
                
            viewController.open(url: "https://www.google.com")
            
            self.observe(viewController.webView.url) { `self`, url in
                if url?.absoluteString.contains("close") == true {
                    self.navigator.dismiss(animated: true)
                }
            }
            
            self.navigator.present(viewController)
        }
        
        row(title: "TextField Animated") { [weak self] in
            guard let self = self else { return }
            let viewController = TextFieldView(navigator: self.navigator)
                .navigationTitle("TextField")
            self.navigator.push(viewController)
        }
        
        row(title: "SegmentedControl") { [weak self] in
            guard let self = self else { return }
            let viewController = SegmentedControlView(navigator: self.navigator)
                .navigationTitle("SegmentedControl")
            self.navigator.push(viewController)
        }
        
        row(title: "ScrollView") { [weak self] in
            guard let self = self else { return }
            let viewController = ScrollViewController(navigator: self.navigator)
                .navigationTitle("ScrollView")
            self.navigator.push(viewController)
        }
        
        row(title: "PickerView") { [weak self] in
            guard let self = self else { return }
            let viewController = PickerViewController(navigator: self.navigator)
                .navigationTitle("PickerView")
            self.navigator.push(viewController)
        }
        
        row(title: "PageControl") { [weak self] in
            guard let self = self else { return }
            let viewController = PageControlViewController(navigator: self.navigator)
                .navigationTitle("PageControl")
            self.navigator.push(viewController)
        }
        
        row(title: "Pager") { [weak self] in
            guard let self = self else { return }
            let viewController = PagerView(navigator: self.navigator)
                .navigationTitle("Pager")
            self.navigator.push(viewController)
        }
        
        row(title: "Label") { [weak self] in
            guard let self = self else { return }
            let viewController = LabelView(navigator: self.navigator)
                .navigationTitle("Label")
            self.navigator.push(viewController)
        }
        
        row(title: "CollectionView") { [weak self] in
            guard let self = self else { return }
            let viewController = CollectionViewController(navigator: self.navigator)
                .navigationTitle("CollectionView")
            self.navigator.push(viewController)
        }
        
        row(title: "ActivityIndicator") { [weak self] in
            guard let self = self else { return }
            let viewController = ActivityIndicatorView(navigator: self.navigator)
                .navigationTitle("ActivityIndicator")
            self.navigator.push(viewController)
        }
    }
    
    func row(title: String, action: @escaping () -> Void) -> Row {
        Label(text: title, style: .boldSystemFont())
            .padding(.uniform(.small))
            .asRow()
            .onTap(action)
    }
}
