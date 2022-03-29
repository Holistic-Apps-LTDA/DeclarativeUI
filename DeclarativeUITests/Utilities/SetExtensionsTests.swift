@testable import DeclarativeUI
import Nimble
import Quick

class SetExtensionsTests: QuickSpec {
    override func spec() {
        describe("Extensões para Sets") {
            context("metodo de containsAny") {
                it("deve retornar true quando existe 1 elemento em comum em ambos sets") {
                    let setA = Set([1, 2, 3])
                    let setB = Set([3, 4, 5])
                    expect(setA.containsAny(of: setB)) == true
                }
                it("deve retornar true quando existe mais de 1 elemento em comum em ambos sets") {
                    let setA = Set([1, 2, 3, 4])
                    let setB = Set([3, 4, 5])
                    expect(setA.containsAny(of: setB)) == true
                }
                it("deve retornar false quando não existe elemento em comum em ambos sets") {
                    let setA = Set([1, 2, 3])
                    let setB = Set([4, 5, 6])
                    expect(setA.containsAny(of: setB)) == false
                }
            }
        }
    }
}
