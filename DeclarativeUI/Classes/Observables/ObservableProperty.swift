
@propertyWrapper
public final class ObservableProperty<Value> {
    private let observable: Observable<Value>

    public convenience init(wrappedValue: Value) {
        self.init(observable: Observable(wrappedValue))
    }
    
    public init(observable: Observable<Value>) {
        self.observable = observable
    }

    public var wrappedValue: Value {
        get { observable.value }
        set { observable.value = newValue }
    }
    
    public var projectedValue: Observable<Value> {
        observable
    }
}
