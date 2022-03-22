import DeclarativeUI

class CollectionViewController: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let navigator: Navigator
    
    public init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    lazy var view = StackView(.vertical) {
        Spacer(.medium)
        CollectionView {
            CellCollection(title: "Cell 1", icon: Icons.triangle)
                .asCell()
                .onTap {
                    print("Cell 1")
                }
            CellCollection(title: "Cell 2", icon: Icons.triangle)
                .asCell()
                .onTap {
                    print("Cell 2")
                }
            CellCollection(title: "Cell 3", icon: Icons.triangle)
                .asCell()
                .onTap {
                    print("Cell 3")
                }
            CellCollection(title: "Cell 4", icon: Icons.triangle)
                .asCell()
                .onTap {
                    print("Cell 4")
                }
            CellCollection(title: "Cell 5", icon: Icons.close)
                .asCell()
                .onTap {
                    print("Cell 5")
                }
            CellCollection(title: "Cell 6", icon: Icons.close)
                .asCell()
                .onTap {
                    print("Cell 6")
                }
            CellCollection(title: "Cell 7", icon: Icons.close)
                .asCell()
                .onTap {
                    print("Cell 7")
                }
            CellCollection(title: "Cell 8", icon: Icons.close)
                .asCell()
                .onTap {
                    print("Cell 8")
                }
        }
        .contentSizeStyle(.content)
            .minimumInteritemSpacing(.medium)
            .minimumLineSpacing(.medium)
            .verticalAlignment(.top)
            .horizontalAlignment(.justified)
            .padding(.horizontal(.extraSmall3))
        Spacer(.flexible)
    }.padding(.horizontal(.medium))

}

class CellCollection: DeclarativeComponent {
    public var title: String
    var icon: FontIcon
    public let view: StackView
    
    public init(title: String, icon: FontIcon) {
        self.title = title
        self.icon = icon
        
        view = StackView(.vertical) {
            Image(DemoImage.close)
                .height(.extraLarge2)
                .width(.extraLarge2)
                .rounded()
                .addShadow(.elevation1)
                .backgroundColor(.white)
            Spacer(.extraSmall)
            Label(text: title, style: .boldSystemFont())
                .numberOfLines(3)
                .alignment(.center)
                .lineBreakMode(.byWordWrapping)
        }.alignment(.center)
    }
}
