import UIKit

public struct ShadowConfiguration: Equatable {
    let offset: CGSize
    let color: CGColor
    let opacity: Float
    let radius: CGFloat
    
    private init(offset: CGSize, color: CGColor, opacity: Float, radius: CGFloat) {
        self.offset = offset
        self.color = color
        self.opacity = opacity
        self.radius = radius
    }
    
    public static func == (lhs: ShadowConfiguration, rhs: ShadowConfiguration) -> Bool {
        return lhs.offset == rhs.offset &&
            lhs.color == rhs.color &&
            lhs.opacity == rhs.opacity &&
            lhs.radius == rhs.radius
    }
}

public extension ShadowConfiguration {
    static let elevation1 = ShadowConfiguration(offset: CGSize(width: 0, height: 3),
                                                color: UIColor(red: 0.035, green: 0.118, blue: 0.259, alpha: 0.25).cgColor,
                                                opacity: 1,
                                                radius: 3)
    
    static let elevation2 = ShadowConfiguration(offset: CGSize(width: 0, height: 8),
                                                color: UIColor(red: 0.035, green: 0.118, blue: 0.259, alpha: 0.2).cgColor,
                                                opacity: 1,
                                                radius: 12)

    static let elevation3 = ShadowConfiguration(offset: CGSize(width: 0, height: 16),
                                                color: UIColor(red: 0.035, green: 0.118, blue: 0.259, alpha: 0.15).cgColor,
                                                opacity: 1,
                                                radius: 30)
}
