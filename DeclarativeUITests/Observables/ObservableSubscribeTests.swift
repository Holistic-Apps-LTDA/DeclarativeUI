import Foundation
import Nimble
import Quick

@testable import DeclarativeUI

class ObservableSubscribeTests: QuickSpec {
    override func spec() {
        describe("ObservableSubscribe") {
            let observable = Observable(0)

            context("when you start an observable after doing a subcribe") {
                it("receives the initial value") {
                    waitUntil { done in
                        _ = observable
                            .subscribe()
                            .onNext { value in
                                expect(value) == 0
                                done()
                            }
                    }
                }
            }
        }
    }
}
