import Quick
import Nimble
@testable import DeclarativeUI

class GradientProviderTests: QuickSpec {
    override func spec() {
        describe("GradientProviderTests") {
            let sut = GradientProviderSpy()
            let view = Label(text: "Test", style: .systemFont())
            let configurator = GradientConfigurator(colors: [.black])
            
            context("when setGradient is called") {
                beforeEach {
                    sut.setGradient(for: view.rootView, configurator: configurator)
                }
                
                it("should add a gradient layer for the view") {
                    expect(sut.setGradientCalled) == true
                    expect(sut.viewArgument) === view.rootView
                    expect(sut.configuratorArgument) == configurator
                    guard let gradientLayer = view.rootView.layer.sublayers?.first as? CAGradientLayer else { return fail() }
                    let gradientColors = gradientLayer.colors?.compactMap({ return ($0 as! CGColor) })
                    expect(gradientColors) == configurator.colors.compactMap({ return $0.value.cgColor })
                    expect(gradientLayer.locations) == configurator.locations
                }
            }
        }
    }
}

// MARK: - GradientProviderSpy

public class GradientProviderSpy: GradientProvider {
    var setGradientCount: Int = 0
    var setGradientCalled: Bool {
        return setGradientCount > 0
    }

    var viewArgument: UIView?
    var configuratorArgument: GradientConfigurator?
    
    override public func setGradient(for view: UIView, configurator: GradientConfigurator) {
        super.setGradient(for: view, configurator: configurator)
        viewArgument = view
        configuratorArgument = configurator
        setGradientCount += 1
    }
}
