import Foundation
import Nimble
import Quick

@testable import DeclarativeUI

class PublisherFunctionsTests: QuickSpec {
    override func spec() {
        describe("Funções do Publisher") {
            var publisher: Publisher<Int>!
            beforeEach {
                publisher = Publisher<Int>()
            }
            context("função FilterMap") {
                it("deve alterar o tipo de retorno e filtrar valores não desejados") {
                    var filteredMappedValues = [String]()
                    _ = publisher.filterMap { value in
                        guard value.isMultiple(of: 2) else {
                            return .reject
                        }
                        return .accept(value.description)
                    }
                    .subscribe().onNext { stringValue in
                        filteredMappedValues.append(stringValue)
                    }
                    
                    for i in 0 ... 10 {
                        publisher.publish(i)
                    }
                    expect(filteredMappedValues).toEventually(equal(["0", "2", "4", "6", "8", "10"]))
                }
            }
            context("função Map") {
                it("deve alterar o tipo de retorno de Int para String") {
                    var mappedValues = [String]()
                    _ = publisher.map(\.description)
                        .subscribe().onNext { stringValue in
                            mappedValues.append(stringValue)
                        }
                    publisher.publish(25)
                    publisher.publish(50)
                    publisher.publish(75)
                    publisher.publish(100)
                    expect(mappedValues).toEventually(equal(["25", "50", "75", "100"]))
                }
            }
            context("função Filter") {
                it("deve filtrar valores não desejados") {
                    var filteredValues = [Int]()
                    _ = publisher.filter { $0.isMultiple(of: 2) }
                        .subscribe().onNext { filteredValue in
                            filteredValues.append(filteredValue)
                        }
                    for i in 0 ... 10 {
                        publisher.publish(i)
                    }
                    expect(filteredValues).toEventually(equal([0, 2, 4, 6, 8, 10]))
                }
            }
            context("função Distinct") {
                it("deve ignorar valores que sejam iguais ao último publicado") {
                    var distinctValues = [Int]()
                    _ = publisher.distinct()
                        .subscribe().onNext { value in
                            distinctValues.append(value)
                        }
                    
                    publisher.publish(0)
                    publisher.publish(0)
                    publisher.publish(1)
                    publisher.publish(0)
                    publisher.publish(1)
                    publisher.publish(1)
                    publisher.publish(1)
                    
                    expect(distinctValues).toEventually(equal([0, 1, 0, 1]))
                }
            }
        }
    }
}
