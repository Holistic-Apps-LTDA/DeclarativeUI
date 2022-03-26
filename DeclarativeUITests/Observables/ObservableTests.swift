import Foundation
import Nimble
import Quick

@testable import DeclarativeUI

class ObservableTests: QuickSpec {
    override func spec() {
        describe("Observable") {
            context("when the observable is created") {
                it("must contain value") {
                    let observable = Observable(0)
                    expect(observable.value) == 0
                }
            }
        }
    }
}



