import Foundation

public class Observable<Value>: Publisher<Value> {
    public init(_ value: Value) {
        self.value = value
    }

    public var value: Value {
        didSet {
            super.publish(value)
        }
    }
    
    override public func publish(_ value: Value) {
        self.value = value
    }

    override func addSubscriber(_ subscriber: Subscriber<Value>) {
        super.addSubscriber(subscriber)
        subscriber.notify(value)
    }
}
