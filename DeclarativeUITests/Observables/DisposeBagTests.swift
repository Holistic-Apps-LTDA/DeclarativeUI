import Foundation
import Nimble
import Quick
@testable import DeclarativeUI

class DisposeBagTests: QuickSpec {
    override func spec() {
        describe("DisposeBag") {
            context("when dealocated") {
                it("should cancel the cancelabels in it") {
                    let cancelables = Array(repeating: CancelableSpy(), count: 10)
                    var disposeBag: DisposeBag? = DisposeBag()
                    cancelables.forEach { cancelable in
                        disposeBag!.insert(cancelable)
                    }
                    disposeBag = nil
                
                    cancelables.forEach { cancelable in
                        expect(cancelable.cancelCalled) == true
                    }
                }
            }
        }
    }
}

class CancelableSpy: CancelableMock, Hashable {
    static func == (lhs: CancelableSpy, rhs: CancelableSpy) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

class CancelableMock: Cancelable {

    //MARK: - cancel

    var cancelCallsCount = 0
    var cancelCalled: Bool {
        return cancelCallsCount > 0
    }
    var cancelClosure: (() -> Void)?

    func cancel() {
        cancelCallsCount += 1
        cancelClosure?()
    }

}
