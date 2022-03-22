import Foundation

public class KVObservable<Object: NSObject, Value>: Observable<Value> {
    private var observation: NSKeyValueObservation?
    public init(object: Object, keyPath: KeyPath<Object, Value>) {
        super.init(object[keyPath: keyPath])
        observation = object.observe(keyPath, options: [.initial, .new]) { [weak self] object, _ in
            self?.publish(object[keyPath: keyPath])
        }
    }
}
