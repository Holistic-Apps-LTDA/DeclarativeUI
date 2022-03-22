import Foundation

public extension DisposeManager where Self: AnyObject {
    @discardableResult
    func observe<Value>(_ publisher: Publisher<Value>,
                        file: StaticString = #file,
                        line: UInt = #line,
                        handler: @escaping (Self) -> Void) -> Subscriber<Value> {
        observe(publisher, file: file, line: line) { `self`, _ in
            handler(self)
        }
    }
    
    @discardableResult
    func observe<Value>(_ publisher: Publisher<Value>,
                        file: StaticString = #file,
                        line: UInt = #line,
                        handler: @escaping (Self, Value) -> Void) -> Subscriber<Value> {
        observe(publisher, file: file, line: line) { `self`, value, _ in
            handler(self, value)
        }
    }

    @discardableResult
    func observe<Value>(_ publisher: Publisher<Value>,
                        file: StaticString = #file,
                        line: UInt = #line,
                        handler: @escaping (Self, Value, Subscriber<Value>) -> Void) -> Subscriber<Value> {
        let subscriber = publisher.subscribe()
            .onNext { [weak self] subscriber, value in
                guard let self = self else {
                    return assertionFailure("self must never be nil here, this is most likelly a programming error",
                                            file: file,
                                            line: line)
                }
                handler(self, value, subscriber)
            }
        subscriber.disposedBy(self)
        return subscriber
    }
}
