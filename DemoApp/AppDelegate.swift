import DeclarativeUI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let navigator = Navigator(backIcon: Image(DemoImage.back), closeIcon: Image(DemoImage.close))

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigator.viewController
        window?.makeKeyAndVisible()
        let view = ModuleDemoView(navigator: navigator)
            .navigationTitle("ListView")
        navigator.push(view, animated: false)
        return true
    }
}

public struct DemoImage {
    public static var back: UIImage { get { return UIImage(named: "back") ?? UIImage() } }
    public static var close: UIImage { get { return UIImage(named: "close") ?? UIImage() } }
}
