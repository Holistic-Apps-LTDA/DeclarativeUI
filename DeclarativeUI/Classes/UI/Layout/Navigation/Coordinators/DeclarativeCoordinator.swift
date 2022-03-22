
public protocol Coordinator {
    var nextCoordinator: Coordinator? { get }
    var navigator: Navigator { get }
    var didFinish: Publisher<DeclarativeCoordinator> { get }
    
    func finish()
    func startNextCoordinator(_ coordinator: Coordinator)
}

open class DeclarativeCoordinator: Coordinator, DisposeManager {
    // MARK: Attributes

    public var disposeBag = DisposeBag()
    
    // MARK: Protocol Attributes

    public private(set) var nextCoordinator: Coordinator?
    public var navigator: Navigator
    public var didFinish: Publisher<DeclarativeCoordinator> = Publisher()
    
    public init(backIcon: Image, closeIcon: Image) {
        navigator = Navigator(backIcon: backIcon, closeIcon: closeIcon)
        observe(navigator.viewController.events.dismissed) { `self`, _, subscriber in
            self.didFinish.publish(self)
            subscriber.cancel()
        }
    }

    // MARK: Protocol Functions

    public func finish() {
        navigator.dismiss()
    }
    
    public func startNextCoordinator(_ coordinator: Coordinator) {
        observe(coordinator.didFinish) { `self`, _, subscriber in
            self.nextCoordinator = nil
            subscriber.cancel()
        }
        navigator.present(coordinator.navigator)
        nextCoordinator = coordinator
    }
}
