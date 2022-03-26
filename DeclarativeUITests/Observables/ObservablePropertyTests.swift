import Foundation
import Nimble
import Quick

@testable import DeclarativeUI

class observablePropertyTests: QuickSpec {
    @ObservableProperty var number: Int = 0
    override func spec() {
        describe("ObservableProperty") {
            beforeEach {
                self._number = ObservableProperty(wrappedValue: 0)
            }
            context("when the observable is created") {
                it("should read and write multiple values") {
                    (0 ... 10).forEach { value in
                        self.number = value
                        expect(self.number) == value
                    }
                }
                it("should be able to observe a series of values") {
                    let expectedValues = Array(self.number ... 10)
                    var receivedValues = [Int]()
                    waitUntil { done in
                        _ = self.$number.subscribe().onNext { value in
                            receivedValues.append(value)
                            if receivedValues.count == expectedValues.count {
                                done()
                            }
                        }
                        // skip first number
                        expectedValues[1...].forEach { value in
                            self.number = value
                        }
                    }
                    expect(receivedValues) == expectedValues
                }
            }
        }
    }
}
