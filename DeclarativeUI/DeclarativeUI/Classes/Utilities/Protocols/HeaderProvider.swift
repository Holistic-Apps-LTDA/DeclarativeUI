import Foundation

public typealias Headers = [String: String?]
extension Headers: HeaderProvider {
    public var headers: Headers { self }
}

public protocol HeaderProvider {
    var headers: Headers { get }
}
