import UIKit

public struct GradientConfigurator: Equatable {
    let colors: [Color]
    let locations: [NSNumber]
    let frame: CGRect?
    
    public init(colors: [Color], locations: [NSNumber] = [0, 1], frame: CGRect? = nil) {
        self.colors = colors
        self.locations = locations
        self.frame = frame
    }
    
    public static func == (lhs: GradientConfigurator, rhs: GradientConfigurator) -> Bool {
        return lhs.colors == rhs.colors &&
            lhs.locations == rhs.locations &&
            lhs.frame == rhs.frame
    }
}

public protocol GradientProviderProtocol: AnyObject {
    func setGradient(for view: UIView, configurator: GradientConfigurator)
}

public class GradientProvider: GradientProviderProtocol {
    private var gradientLayer = CAGradientLayer()
    
    public init() {}
    
    public func setGradient(for view: UIView, configurator: GradientConfigurator) {
        gradientLayer.colors = configurator.colors.compactMap({ return $0.value.cgColor })
        gradientLayer.locations = configurator.locations
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = configurator.frame ?? .zero
    }
}
