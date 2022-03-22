import Foundation

public class Subscriber<Value>: Hashable, Cancelable {
    private weak var publisher: Publisher<Value>?
    private var nextHandler: ((Subscriber, Value) -> Void)?
    private var cancelHandler: ((Subscriber) -> Void)?
    
    public init(publisher: Publisher<Value>) {
        self.publisher = publisher
    }
}

// MARK: Subscription

public extension Subscriber {
    func onNext(_ handler: @escaping (Subscriber, Value) -> Void) -> Self {
        nextHandler = handler
        publisher?.addSubscriber(self)
        return self
    }
    
    func onNext(_ handler: @escaping (Value) -> Void) -> Self {
        onNext { _, value in
            handler(value)
        }
    }
}

// MARK: Notification

public extension Subscriber {
    func notify(_ value: Value) {
        nextHandler?(self, value)
    }
}

// MARK: Cancelation

public extension Subscriber {
    func onCancel(_ handler: @escaping (Subscriber) -> Void) -> Self {
        cancelHandler = handler
        return self
    }
    
    func cancel() {
        cancelHandler?(self)
        nextHandler = nil
        publisher?.removeSubscriber(self)
    }
}

// MARK: Disposing

public extension Subscriber {
    func disposedBy(_ disposeManager: DisposeManager) {
        disposedBy(disposeManager.disposeBag)
    }
    
    func disposedBy(_ disposeBag: DisposeBag) {
        disposeBag.insert(self)
    }
}

// MARK: Hashable & Equatable

public extension Subscriber {
    static func == (lhs: Subscriber<Value>, rhs: Subscriber<Value>) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
