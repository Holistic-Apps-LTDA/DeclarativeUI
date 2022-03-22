import DeclarativeUI

class ModuleDemoView: DeclarativeViewController {    
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    lazy var view = ListView {
        row(title: "Base Views") { [weak self] in
            guard let self = self else { return }
            let viewController = BaseViews(navigator: self.navigator)
                .navigationTitle("Base Views")
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
