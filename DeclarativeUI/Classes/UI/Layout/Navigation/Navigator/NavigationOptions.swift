
public struct NavigationOptions: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let back = NavigationOptions(rawValue: 1 << 0)
    public static let close = NavigationOptions(rawValue: 1 << 1)
    public static let `default`: NavigationOptions = [.back, .close]
    public static let none: NavigationOptions = []
}
