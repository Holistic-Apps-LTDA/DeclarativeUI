@testable import DeclarativeUI
import Nimble
import Quick

class DeclarativeViewModelTests: QuickSpec {
    override func spec() {
        describe("DeclarativeViewModelTests") {
            var sut: DeclarativeViewModel<Any, DefaultError>?
            let disposeBag = DisposeBag()
            
            beforeEach {
                sut = DeclarativeViewModel()
            }
            
            context("Quando o DeclarativeViewModel é instanciado") {
                it("Deverá inicializar o disposeBag") {
                    expect(sut?.disposeBag).toNot(beNil())
                }
            }
            
            context("Quando o finish é chamado") {
                beforeEach {
                    sut?.finish()
                }
                
                sut?.didFinish.subscribe().onNext { value in
                    it("Deverá publicar o didFinish") {
                        expect(value.isEmpty) == true
                    }
                }.disposedBy(disposeBag)
            }
        }
    }
}

struct DefaultError: Error {}
