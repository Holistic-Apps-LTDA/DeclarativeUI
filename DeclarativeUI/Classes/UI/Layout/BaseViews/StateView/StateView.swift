import UIKit

public class StateView<Value, ErrorType: Error>: DeclarativeComponent, DisposeManager {
    public var disposeBag = DisposeBag()
    
    public typealias ViewState = State<Value, ErrorType>
    public typealias ViewBuilder = (ViewState) -> [UIViewConvertible]

    public let view = StackView(.vertical)
    private let stateEvents = StateEvents()
        
    public init() {}
    
    public func observe(_ state: Observable<ViewState>) -> Self {
        observe(state) { `self`, state in
            switch state {
            case .loading:
                self.stateEvents.onLoading.publish(())
            case .ready(let value):
                self.stateEvents.onReady.publish(value)
            case .error(let error):
                self.stateEvents.onError.publish(error)
            case .empty:
                self.stateEvents.onEmpty.publish(())
            }
        }
        return self
    }
}

public extension StateView {
    private class StateEvents {
        let onEmpty = Publisher<Void>()
        let onLoading = Publisher<Void>()
        let onReady = Publisher<Value>()
        let onError = Publisher<ErrorType>()
    }
    
    func onEmpty(@UIViewBuilder _ views: @escaping () -> [UIViewConvertible]) -> Self {
        observe(stateEvents.onEmpty) { `self` in
            self.update(views)
        }
        return self
    }
    
    func onLoading(@UIViewBuilder _ views: @escaping () -> [UIViewConvertible]) -> Self {
        observe(stateEvents.onLoading) { `self` in
            self.update(views)
        }
        return self
    }
    
    func onReady(@UIViewBuilder _ views: @escaping (Value) -> [UIViewConvertible]) -> Self {
        observe(stateEvents.onReady) { `self`, value in
            self.update {
                views(value)
            }
        }
        return self
    }
    
    func onError(@UIViewBuilder _ views: @escaping (ErrorType) -> [UIViewConvertible]) -> Self {
        observe(stateEvents.onError) { `self`, error in
            self.update {
                views(error)
            }
        }
        return self
    }
     
    private func update(@UIViewBuilder _ views: @escaping () -> [UIViewConvertible]) {
        view.update(views)
    }
}

