import UIKit

public struct NavigationBarStyle: Equatable {
    var tintColor: Color
    var backgroundColor: Color
    var statusBarStyle: UIStatusBarStyle
}

public extension NavigationBarStyle {

    static let light = NavigationBarStyle(tintColor: .black, backgroundColor: .white, statusBarStyle: .default)

    static let dark = NavigationBarStyle(tintColor: .white, backgroundColor: .black, statusBarStyle: .lightContent)
}
