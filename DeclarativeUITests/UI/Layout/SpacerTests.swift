import Quick
import Nimble
@testable import DeclarativeUI

class SpacerTests: QuickSpec {
    override func spec() {
        describe("SpacerTests") {
            var spacer: Spacer!
            
            context("when the spacer isn't flexible") {
                beforeEach {
                    spacer = Spacer(.extraLarge)
                }
                
                it("should have its priorities 0 and constraint") {
                    expect(spacer.rootView.contentHuggingPriority(for: .horizontal)) == .required
                    expect(spacer.rootView.contentHuggingPriority(for: .vertical)) == .required
                    expect(spacer.rootView.contentCompressionResistancePriority(for: .horizontal)) == .required
                    expect(spacer.rootView.contentCompressionResistancePriority(for: .vertical)) == .required
                    let constraints = spacer.rootView.constraints
                    expect(constraints[0].constant) == Size.extraLarge.value
                    expect(constraints[1].constant) == Size.extraLarge.value
                }
            }
            
            context("when the spacer is flexible") {
                beforeEach {
                    spacer = Spacer(.flexible)
                }
                
                it("should have its priorities 0 and no constraints") {
                    expect(spacer.rootView.contentHuggingPriority(for: .horizontal)) == UILayoutPriority(0)
                    expect(spacer.rootView.contentHuggingPriority(for: .vertical)) == UILayoutPriority(0)
                    expect(spacer.rootView.contentCompressionResistancePriority(for: .horizontal)) == UILayoutPriority(0)
                    expect(spacer.rootView.contentCompressionResistancePriority(for: .vertical)) == UILayoutPriority(0)
                    expect(spacer.rootView.constraints) == []
                }
            }
        }
    }
}
