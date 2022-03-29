import Foundation
import UIKit

public extension DeclarativeView {
    @discardableResult
    func addShadow(_ shadow: ShadowConfiguration) -> Self {
        rootView.observe(rootView.events.didLayoutSubviews) { view in
            view.layer.shadowOffset = shadow.offset
            view.layer.shadowColor = shadow.color
            view.layer.shadowOpacity = shadow.opacity
            view.layer.shadowRadius = shadow.radius
            view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
            view.layer.shouldRasterize = true
            view.layer.rasterizationScale = UIScreen.main.scale
            view.layer.masksToBounds = false
        }
        return self
    }
    
    @discardableResult
    func removeShadow() -> Self {
        rootView.layer.shadowOffset = .zero
        rootView.layer.shadowColor = .none
        rootView.layer.shadowOpacity = 0
        rootView.layer.shadowRadius = 0
        rootView.layer.shadowPath = nil
        rootView.layer.shouldRasterize = false
        rootView.layer.rasterizationScale = UIScreen.main.scale
        rootView.layer.masksToBounds = false
        return self
    }

    @discardableResult
    func squared(_ size: Size) -> Self {
        squared(.equal(size))
    }
    
    @discardableResult
    func squared(_ size: Layout.Relation<Size>) -> Self {
        self.size(width: size, height: size)
        return self
    }

    @discardableResult
    func border(_ color: Color, width: Size) -> Self {
        rootView.layer.borderColor = color.value.cgColor
        rootView.layer.borderWidth = width.value
        return self
    }
    
    @discardableResult
    func aspectRatio(_ ratio: CGFloat) -> Self {
        rootView.layout.aspectRatio(ratio)
        return self
    }
    
    @discardableResult
    func size(width: Size, height: Size) -> Self {
        size(width: .equal(width), height: .equal(height))
    }
    
    @discardableResult
    func size(width: Layout.Relation<Size>, height: Layout.Relation<Size>) -> Self {
        self.width(width)
        self.height(height)
        return self
    }
    
    @discardableResult
    func height(_ size: Size) -> Self {
        height(.equal(size))
    }
    
    @discardableResult
    func height(_ size: Layout.Relation<Size>) -> Self {
        rootView.layout.height(size.map(\.value))
        return self
    }
    
    @discardableResult
    func width(_ size: Size) -> Self {
        width(.equal(size))
    }
    
    @discardableResult
    func width(_ size: Layout.Relation<Size>) -> Self {
        rootView.layout.width(size.map(\.value))
        return self
    }
    
    @discardableResult
    func addGradient(colors: [Color], locations: [NSNumber] = [0, 1]) -> Self {
        rootView.observe(rootView.events.didLayoutSubviews) { view in
            GradientProvider().setGradient(for: view, configurator: GradientConfigurator(colors: colors, locations: locations, frame: view.bounds))
        }
        return self
    }
    
    @discardableResult
    func backgroundView(_ view: UIViewConvertible, configuration: @escaping (Layout) -> Void) -> Self {
        rootView.layout.addSubview(view)
        configuration(view.layout)
        rootView.sendSubviewToBack(view.uiView)
        return self
    }
    
    @discardableResult
    func subview<View: UIViewConvertible>(_ subview: View, configuration: (Layout) -> Void) -> Self {
        rootView.layout.addSubview(subview)
        configuration(subview.layout)
        return self
    }
    
    @discardableResult
    func layout(configuration: @escaping (Layout) -> Void) -> Self {
        rootView.observe(rootView.events.didMoveToSuperview) { _, view, subscriber in
            guard view.superview != nil else { return }
            configuration(view.layout)
            subscriber.cancel()
        }
        return self
    }
    
    @discardableResult
    func expansionResistance(_ priority: UILayoutPriority) -> Self {
        rootView.setContentHuggingPriority(priority, for: .vertical)
        rootView.setContentHuggingPriority(priority, for: .horizontal)
        return self
    }
    
    @discardableResult
    func compressionResistance(_ priority: UILayoutPriority) -> Self {
        rootView.setContentCompressionResistancePriority(priority, for: .vertical)
        rootView.setContentCompressionResistancePriority(priority, for: .horizontal)
        return self
    }
    
    @discardableResult
    func userInteractionEnabled(_ enabled: Bool) -> Self {
        rootView.isUserInteractionEnabled = enabled
        return self
    }
    
    @discardableResult
    func userInteractionEnabled(_ enabled: Observable<Bool>) -> Self {
        rootView.observe(enabled) { view, enabled in
            view.userInteractionEnabled(enabled)
        }
        return self
    }
    
    @discardableResult
    func configuration(_ configuration: @escaping (Self) -> Void) -> Self {
        configuration(self)
        return self
    }
}
