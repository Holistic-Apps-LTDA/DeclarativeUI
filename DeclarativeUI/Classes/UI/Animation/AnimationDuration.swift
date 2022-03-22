public struct AnimationDuration {
    public var value: TimeInterval
    fileprivate init(_ value: TimeInterval) {
        self.value = value
    }
        
    public static let zero = AnimationDuration(0)
    public static let `default` = AnimationDuration(0.3)
    public static let transition = AnimationDuration(0.2)
    public static func custom(_ value: TimeInterval) -> AnimationDuration {
        AnimationDuration(value)
    }
}

public func * (lhs: AnimationDuration, rhs: Double) -> AnimationDuration {
    return AnimationDuration(lhs.value * rhs)
}
