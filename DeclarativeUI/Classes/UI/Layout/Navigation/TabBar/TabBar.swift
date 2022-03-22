import UIKit

public class TabBar: DeclarativeViewController {
    private let tabBarController: TabBarController
    public var viewController: TabBarController { tabBarController }
    private var viewControllers = [UIViewControllerConvertible]()
    
    public init() {
        tabBarController = TabBarController()
        let tabBar = tabBarController.tabBar
        tabBar.tintColor = Color.black.value
        tabBar.barTintColor = Color.white.value
        tabBar.unselectedItemTintColor = Color.black.value
        tabBar.itemWidth = Size.extraLarge4.value
        tabBar.itemSpacing = Size.extraSmall2.value
        tabBar.itemPositioning = .centered
        tabBar.backgroundColor = Color.white.value
    }

    public convenience init(viewControllers: [UIViewControllerConvertible]) {
        self.init()
        setViewControllers(viewControllers, animated: false)
    }

    public func setViewControllers(_ viewControllers: [UIViewControllerConvertible],
                            animated: Bool = true) {
        self.viewControllers = viewControllers
        tabBarController.setViewControllers(viewControllers.map(\.uiViewController),
                                            animated: animated)
    }
    
    public func selectIndex(_ index: Int) {
        tabBarController.selectedIndex = index
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI.Group {
            ViewControllerContainer(view: tabBar)
                .previewDevice("iPhone SE (1st generation)")
            ViewControllerContainer(view: tabBar)
                .previewDevice("iPhone 12")
        }
    }

    static var tabBar: TabBar {
        TabBar(viewControllers: [
            ViewController(view: UIView()).tabBarItem(TabBarItem(title: "Início",
                                                                 icon: FontIcon(name: "Triangle", unicode: "\u{0394}", font: .systemFont(ofSize: 15)),
                                                                 iconSelected: Icons.triangle)),
            ViewController(view: UIView()).tabBarItem(TabBarItem(title: "Conta",
                                                                 icon: FontIcon(name: "Triangle", unicode: "\u{0394}", font: .systemFont(ofSize: 15)),
                                                                 iconSelected: Icons.triangle)),
            ViewController(view: UIView()).tabBarItem(TabBarItem(title: "Cartões",
                                                                 icon: FontIcon(name: "Triangle", unicode: "\u{0394}", font: .systemFont(ofSize: 15)),
                                                                 iconSelected: Icons.close)),
            ViewController(view: UIView()).tabBarItem(TabBarItem(title: "Comprar",
                                                                 icon: FontIcon(name: "Triangle", unicode: "\u{0394}", font: .systemFont(ofSize: 15)),
                                                                 iconSelected: Icons.triangle)),
            ViewController(view: UIView()).tabBarItem(TabBarItem(title: "Perfil",
                                                                 icon: FontIcon(name: "Triangle", unicode: "\u{0394}", font: .systemFont(ofSize: 15)),
                                                                 iconSelected: Icons.triangle)),
        ])
    }
}
