@testable import DeclarativeUI
import Nimble
import Quick

class CollectionExtensionsTests: QuickSpec {
    override func spec() {
        let array = [0, 1, 2]
        describe("Extensões para Collections") {
            context("quando acessando um indice que pode ou não existir") {
                it("deve retornar o elemento caso o indice exista") {
                    expect(array.element(at: 0)) == 0
                    expect(array.element(at: 1)) == 1
                    expect(array.element(at: 2)) == 2
                }
                it("deve retornar nil caso o indice não exista") {
                    expect(array.element(at: -1)).to(beNil())
                    expect(array.element(at: 3)).to(beNil())
                }
            }
        }
    }
}
