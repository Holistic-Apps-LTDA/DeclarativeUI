public protocol DismissInterceptor: AnyObject {
    func interceptClose(navigator: Navigator)
}

public protocol BackInterceptor: AnyObject {
    func interceptBack(navigator: Navigator)
}
