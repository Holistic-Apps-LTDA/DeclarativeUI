import Foundation
import SwiftOrderedSet

public class Publisher<Value> {
    public typealias Handler = (Value) -> Void
    private(set) var subscribers = OrderedSet<Subscriber<Value>>()
    private(set) var previousValue: Value?
    private(set) var currentValue: Value?
    public init() {}

    func addSubscriber(_ subscriber: Subscriber<Value>) {
        subscribers.append(subscriber)
    }
    
    func removeSubscriber(_ subscriber: Subscriber<Value>) {
        subscribers.remove(subscriber)
    }

    public func publish(_ value: Value) {
        previousValue = currentValue
        currentValue = value
        subscribers.forEach { subscriber in
            subscriber.notify(value)
        }
    }
    
    public func subscribe() -> Subscriber<Value> {
        Subscriber<Value>(publisher: self)
    }
}

public enum FilterResult<Value> {
    case accept(Value)
    case reject
}

public extension Publisher {
    func filterMap<NewValue>(_ transform: @escaping (Value) -> FilterResult<NewValue>) -> Publisher<NewValue> {
        let publisher = Publisher<NewValue>()
        _ = subscribe()
            .onNext { value in
                switch transform(value) {
                case .accept(let newValue):
                    publisher.publish(newValue)
                case .reject:
                    return
                }
            }
        return publisher
    }
    
    func map<NewValue>(_ transform: @escaping (Value) -> NewValue) -> Publisher<NewValue> {
        filterMap { value in
            .accept(transform(value))
        }
    }
    
    func filter(_ isIncluded: @escaping (Value) -> Bool) -> Publisher<Value> {
        filterMap { value in
            guard isIncluded(value) else {
                return .reject
            }
            return .accept(value)
        }
    }

    func distinct() -> Publisher<Value> where Value: Equatable {
        filter { value in
            value != self.previousValue
        }
    }
    
    func inverse() -> Publisher<Bool> where Value == Bool {
        map { value in
            !value
        }
    }
}
