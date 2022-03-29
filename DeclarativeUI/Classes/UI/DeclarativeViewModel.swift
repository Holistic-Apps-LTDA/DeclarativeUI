
open class DeclarativeViewModel<T, ErrorValue: Error>: DisposeManager {
    // MARK: Attributes

    public var disposeBag = DisposeBag()
    
    // MARK: Protocol Attributes
    
    @ObservableProperty
    public var state: State<T, ErrorValue> = .empty
    public var didFinish: Publisher<State<T, ErrorValue>> = Publisher()
    
    // MARK: Life Cycle
    
    public init() { }
    
    // MARK: Protocol Functions
    
    public func finish() {
        didFinish.publish(state)
    }
}
