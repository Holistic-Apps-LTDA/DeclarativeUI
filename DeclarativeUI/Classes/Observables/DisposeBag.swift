import Foundation

public protocol DisposeManager {
    var disposeBag: DisposeBag { get }
}

public final class DisposeBag {
    private var cancelables = Set<AnyHashable>()
    public init() {}
    
    public func insert<Element: Cancelable & Hashable>(_ element: Element) {
        cancelables.insert(AnyHashable(element))
    }
    
    public func disposeAll() {
        cancelables.forEach { cancelable in
            (cancelable.base as? Cancelable)?.cancel()
        }
    }
    
    deinit {
        disposeAll()
    }
}
