import UIKit

public struct ProgressStep {
    public var current: Int
    public var total: Int
    
    public init(current: Int = 0, total: Int = 0) {
        self.current = current
        self.total = total
    }
}
