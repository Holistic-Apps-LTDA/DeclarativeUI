import UIKit

public typealias TextAlignment = NSTextAlignment

extension TextAlignment: CustomStringConvertible {
    public var description: String {
        switch self {
        case .left:
            return "left"
        case .center:
            return "center"
        case .right:
            return "right"
        case .justified:
            return "justified"
        case .natural:
            return "natural"
        @unknown default:
            return "unknown"
        }
    }
    
    public static var all: [TextAlignment] {
        [
            .left,
            .center,
            .right,
            .justified,
            .natural,
        ]
    }
}
