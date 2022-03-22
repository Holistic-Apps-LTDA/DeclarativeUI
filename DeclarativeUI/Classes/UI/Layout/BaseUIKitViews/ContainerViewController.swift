import UIKit

public class ContainerViewController: ViewController {
    public init(viewController: UIViewController) {
        super.init(view: viewController.view)
        addChild(viewController)
    }
}
