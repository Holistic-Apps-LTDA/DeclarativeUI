import Foundation

public enum State<Value, ErrorType> where ErrorType: Error {
    case empty
    case loading
    case ready(Value)
    case error(ErrorType)
    
    public var value: Value? {
        switch self {
        case .ready(let value):
            return value
        default:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
    
    public var isReady: Bool {
        value != nil
    }
    
    public var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
    
    public var isEmpty: Bool {
        switch self {
        case .empty:
            return true
        default:
            return false
        }
    }
}
