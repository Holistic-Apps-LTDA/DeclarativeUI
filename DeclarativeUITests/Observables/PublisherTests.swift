import Foundation
import Nimble
import Quick

@testable import DeclarativeUI

class PublisherTests: QuickSpec {
    override func spec() {
        describe("Publisher") {
            var publisher: Publisher<Int>!
            var subscriber: Subscriber<Int>!
            beforeEach {
                publisher = Publisher<Int>()
                subscriber = publisher.subscribe()
            }
            context("when the subscriber is created") {
                it("should be stored in the publisher after a handlers is registered") {
                    expect(publisher.subscribers).to(beEmpty())
                    _ = subscriber.onNext { _ in }
                    expect(publisher.subscribers).to(contain(subscriber))
                }
                it("should publish multiple values") {
                    let expectedValues = Array(0 ... 10)
                    var receivedValues = [Int]()
                    waitUntil { done in
                        _ = subscriber.onNext { value in
                            receivedValues.append(value)
                            if receivedValues.count == expectedValues.count {
                                done()
                            }
                        }
                        expectedValues.forEach { value in
                            publisher.publish(value)
                        }
                    }
                    expect(receivedValues) == expectedValues
                }
            }
            context("when the subscriber is canceled") {
                it("should be removed the publisher") {
                    _ = subscriber.onNext { _ in }
                    subscriber.cancel()
                    expect(publisher.subscribers).toNot(contain(subscriber))
                }
            }
            context("when multiple subscribers are created") {
                it("must store them all") {
                    var subscribers = [Subscriber<Int>]()
                    let number = Int.random(in: 0 ... 1000)
                    (0 ... 10).forEach { _ in
                        let subscriber = publisher.subscribe().onNext { value in
                            expect(value) == number
                        }
                        subscribers.append(subscriber)
                    }
                    publisher.publish(number)
                    expect(publisher.subscribers).to(contain(subscribers))
                }
            }
        }
    }
}
