import Foundation
import Nimble
import Quick

@testable import DeclarativeUI

class SubscriberTests: QuickSpec {
    override func spec() {
        describe("Subscriber") {
            let publisher = Publisher<Int>()
            let subscriber = Subscriber(publisher: publisher)
            context("quando registrado um handler") {
                it("recebe notificações sob demanda") {
                    waitUntil { done in
                        _ = subscriber.onNext { sub, value in
                            expect(sub) === subscriber
                            expect(value) == 0
                            done()
                        }
                        subscriber.notify(0)
                    }
                    
                    waitUntil { done in
                        _ = subscriber.onNext { value in
                            expect(value) == 1
                            done()
                        }
                        subscriber.notify(1)
                    }
                }
            }
            context("quando adicionada em um Publisher") {
                beforeEach {
                    publisher.addSubscriber(subscriber)
                }
                it("deve ser armazenado no publisher") {
                    expect(publisher.subscribers).to(contain(subscriber))
                }
            
                context("quando cancelado por uma DisposeBag") {
                    beforeEach {
                        var disposeBag: DisposeBag? = DisposeBag()
                        subscriber.disposedBy(disposeBag!)
                        disposeBag = nil
                    }
                    it("deve ser removido do publisher") {
                        expect(publisher.subscribers).toNot(contain(subscriber))
                    }
                }
                context("quando cancelado por um DisposeManager") {
                    beforeEach {
                        var disposeManager: DisposeManagerDummy? = .init()
                        subscriber.disposedBy(disposeManager!)
                        disposeManager = nil
                    }
                    it("deve ser removido do publisher") {
                        expect(publisher.subscribers).toNot(contain(subscriber))
                    }
                }
                context("quando cancelado") {
                    var cancelCalled = false
                    beforeEach {
                        publisher.addSubscriber(subscriber)
                        _ = subscriber.onCancel { _ in
                            cancelCalled = true
                        }
                        subscriber.cancel()
                    }
                    it("deve ser removido do publisher") {
                        expect(publisher.subscribers).toNot(contain(subscriber))
                    }
                    it("deve executar cancelHandler") {
                        expect(cancelCalled) == true
                    }
                }
            }
        }
    }
}

struct DisposeManagerDummy: DisposeManager {
    var disposeBag = DisposeBag()
}
