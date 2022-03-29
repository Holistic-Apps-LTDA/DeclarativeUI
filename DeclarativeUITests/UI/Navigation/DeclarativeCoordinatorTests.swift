@testable import DeclarativeUI
import Nimble
import Quick
import SwiftUI

class DeclarativeCoordinatorTests: QuickSpec {
    override func spec() {
        describe("DeclarativeCoordinatorTests") {
            var sut: DeclarativeCoordinator?
            
            beforeEach {
                sut = DeclarativeCoordinator(backIcon: Image(), closeIcon: Image())
            }
            
            context("Quando o DeclarativeCoordinatorTests é instanciado") {
                it("Deverá inicializar seus atributos") {
                    expect(sut?.disposeBag).toNot(beNil())
                    expect(sut?.navigator).toNot(beNil())
                }
            }
            
            context("Quando o nextCoordinator é iniciado") {
                let nextCoordinator = DeclarativeCoordinator(backIcon: Image(), closeIcon: Image())
                
                beforeEach {
                    sut?.startNextCoordinator(nextCoordinator)
                }
                
                it("Deverá ter sua referência salva no parent coordinator") {
                    expect(sut?.nextCoordinator).toNot(beNil())
                    expect(sut?.nextCoordinator) === nextCoordinator
                    expect(sut?.nextCoordinator?.navigator.uiViewController.isBeingPresented).to(beTrue())
                    expect(sut?.nextCoordinator?.navigator.uiViewController.presentingViewController) === sut?.navigator.uiViewController
                }
            }
            
            context("Quando o coordinator é terminado") {
                let nextCoordinator = DeclarativeCoordinator(backIcon: Image(), closeIcon: Image())
                sut?.startNextCoordinator(nextCoordinator)
                
                beforeEach {
                    sut?.nextCoordinator?.finish()
                }
                
                it("Deverá limpar as referências") {
                    expect(sut?.nextCoordinator).to(beNil())
                }
            }
        }
    }
}

class MockViewController: DeclarativeViewController {
    var viewController = ViewController(view: Spacer(.flexible))
    
    init () {}
}
