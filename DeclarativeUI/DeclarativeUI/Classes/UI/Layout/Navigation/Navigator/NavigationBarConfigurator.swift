import Foundation

public protocol NavigationBarConfigurator: AnyObject {
    var navigationBarConfiguration: NavigationBarConfiguration { get set }
}

public extension DeclarativeViewController where Controller: NavigationBarConfigurator {
    @discardableResult
    func navigationBarStyle(_ style: NavigationBarStyle) -> Self {
        viewController.navigationBarConfiguration.style = style
        (viewController as? StatusBarConfigurator)?
            .statusBarStyle(style.statusBarStyle)
        
        return self
    }
    
    @discardableResult
    func navigationBarHidden(_ hidden: Bool = true) -> Self {
        viewController.navigationBarConfiguration.hidden = hidden
        return self
    }
    
    @discardableResult
    func navigationBarOptions(_ options: NavigationOptions...) -> Self {
        viewController.navigationBarConfiguration.options = NavigationOptions(options)
        return self
    }
    
    @discardableResult
    func progress(_ current: Int, of total: Int) -> Self {
        viewController.navigationBarConfiguration.progress = ProgressStep(current: current, total: total)
        return self
    }
    
    @discardableResult
    func navigationLeftButton(icon: Image,
                              isHidden: Publisher<Bool> = Observable(false),
                              action: @escaping () -> Void) -> Self {
        viewController.navigationBarConfiguration.leftButton = .init(icon: icon,
                                                                     isHidden: isHidden,
                                                                     action: action)
        return self
    }
    
    @discardableResult
    func navigationRightButton(icon: Image,
                               isHidden: Publisher<Bool> = Observable(false),
                               action: @escaping () -> Void) -> Self {
        viewController.navigationBarConfiguration.rightButton = .init(icon: icon,
                                                                      isHidden: isHidden,
                                                                      action: action)
        return self
    }
}
