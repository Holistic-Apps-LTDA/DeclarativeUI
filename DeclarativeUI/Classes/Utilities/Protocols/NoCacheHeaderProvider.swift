import Foundation

public struct NoCacheHeaderProvider: HeaderProvider {
    public var headers: Headers {
        [
            "Cache-Control": "no-cache, no-store, must-revalidate",
            "Pragma": "no-cache",
            "Expires": "0",
        ]
    }
    
    public init() {}
}
