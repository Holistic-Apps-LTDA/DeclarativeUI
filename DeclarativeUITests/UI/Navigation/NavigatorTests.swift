@testable import DeclarativeUI
import Nimble
import Quick

class NavigatorTests: QuickSpec {
    override func spec() {
        describe("Navigator") {
            var rootViewController: DummyViewController!
            var pushedViewController: DummyViewController!
            var presentedViewController: DummyViewController!
            var navigator: Navigator!
            var presentedNavigator: Navigator!
            var navigationController: NavigationController {
                navigator.viewController
            }
            context("quando instanciado com root") {
                beforeEach {
                    rootViewController = DummyViewController()
                    navigator = Navigator(root: rootViewController, backIcon: Image(), closeIcon: Image())
                }
                
                it("deve ter a view controller na hierarquia do Navigator") {
                    expect(navigator.viewControllers.ns) == [rootViewController.uiViewController: rootViewController].ns
                }
                
                it("deve ter a view controller na hierarquia do NavigationController") {
                    expect(navigationController.viewControllers) == [rootViewController.uiViewController]
                }
                
                context("quando feito push") {
                    beforeEach {
                        pushedViewController = DummyViewController()
                        navigator.push(pushedViewController, animated: false)
                    }
                    
                    it("deve exibir a view controller") {
                        expect(navigationController.topViewController) == pushedViewController.uiViewController
                    }
                    
                    it("deve ter a view controller na hierarquia do Navigator") {
                        expect(navigator.viewControllers.ns) == [
                            rootViewController.uiViewController: rootViewController,
                            pushedViewController.uiViewController: pushedViewController,
                        ].ns
                    }
                    
                    it("deve ter a view controller na hierarquia do Navigation Controller") {
                        expect(navigationController.viewControllers) == [
                            rootViewController.uiViewController,
                            pushedViewController.uiViewController,
                        ]
                    }

                    context("quando feito pop") {
                        beforeEach {
                            waitUntil { done in
                                navigator.goBack(animated: false, completion: done)
                            }
                        }
                        it("deve voltar para a view controller anterior") {
                            expect(navigationController.topViewController) != pushedViewController.uiViewController
                            expect(navigationController.topViewController) == rootViewController.uiViewController
                        }
                        it("deve remover o view controller da hierarquia do Navigator") {
                            expect(navigator.viewControllers.values.ns).toNot(contain(pushedViewController))
                        }

                        it("deve remover o view controller da hierarquia do Navigation Controller") {
                            expect(navigationController.viewControllers).toNot(contain(pushedViewController.uiViewController))
                        }
                    }
                }
                
                context("quando feito push and replace") {
                    beforeEach {
                        pushedViewController = DummyViewController()
                        waitUntil { done in
                            navigator.pushAndReplace(pushedViewController, animated: false, completion: done)
                        }
                    }
                    
                    it("deve exibir a view controller") {
                        expect(navigationController.topViewController) == pushedViewController.uiViewController
                    }
                    
                    it("deve substituir a root na hierarquia do Navigator") {
                        expect(navigator.viewControllers.ns) == [
                            pushedViewController.uiViewController: pushedViewController,
                        ].ns
                    }
                    
                    it("deve substituir a root na hierarquia do Navigation Controller") {
                        expect(navigationController.viewControllers) == [
                            pushedViewController.uiViewController,
                        ]
                    }
                }
                
                context("quando feito pop") {
                    beforeEach {
                        navigator.goBack()
                    }
                    it("deve permanecer no root") {
                        expect(navigationController.topViewController) == rootViewController.uiViewController
                    }
                    it("deve manter o root na hierarquia do Navigator") {
                        expect(navigator.viewControllers.ns) == [rootViewController.uiViewController: rootViewController].ns
                    }

                    it("deve manter o root na hierarquia do NavigationController") {
                        expect(navigationController.viewControllers) == [rootViewController.uiViewController]
                    }
                }
                
                context("quando feito present de uma DeclarativeViewController") {
                    beforeEach {
                        presentedViewController = DummyViewController()
                        navigator.present(presentedViewController, animated: false)
                    }
                    
                    it("deve exibir a view controller") {
                        expect(navigationController.presentedViewController) == presentedViewController.uiViewController
                    }
                    
                    it("deve ter a view controller na hierarquia do Navigator") {
                        expect(navigationController.viewControllers) == [rootViewController.uiViewController]
                        expect(navigator.viewControllers.ns) == [
                            rootViewController.uiViewController: rootViewController,
                            presentedViewController.uiViewController: presentedViewController,
                        ].ns
                    }
                    
                    context("quando feito dismiss pelo Navigator") {
                        beforeEach {
                            waitUntil { done in
                                navigator.dismiss(animated: false, completion: done)
                            }
                        }
                        
                        it("deve dispensar a view controller") {
                            expect(navigationController.viewControllers) == [rootViewController.uiViewController]
                            expect(navigationController.presentedViewController).to(beNil())
                        }
                        
                        it("deve remover a view controller apresentada da hierarquia do Navigator") {
                            expect(navigator.viewControllers.ns) == [
                                rootViewController.uiViewController: rootViewController,
                            ].ns
                        }
                    }
                    
                    context("quando feito dismiss pelo view controller apresentado") {
                        beforeEach {
                            waitUntil { done in
                                presentedViewController.uiViewController
                                    .dismiss(animated: false, completion: done)
                            }
                        }
                        
                        it("deve dispensar a view controller") {
                            expect(navigationController.viewControllers) == [rootViewController.uiViewController]
                            expect(navigationController.presentedViewController).to(beNil())
                        }
                        
                        it("deve remover a view controller apresentada da hierarquia do Navigator") {
                            let vc = presentedViewController.uiViewController
                            print(vc)
                            expect(navigator.viewControllers).to(haveCount(1))
                            expect(navigator.viewControllers.ns) == [
                                rootViewController.uiViewController: rootViewController,
                            ].ns
                        }
                    }
                }
                context("quando feito present de um Navigator") {
                    beforeEach {
                        presentedNavigator = Navigator(root: DummyViewController(), backIcon: Image(), closeIcon: Image())
                        navigator.present(presentedNavigator, animated: false)
                    }
                        
                    it("deve exibir a view controller") {
                        expect(navigationController.presentedViewController) == presentedNavigator.uiViewController
                    }
                        
                    it("deve ter a view controller na hierarquia do Navigator") {
                        expect(navigationController.viewControllers) == [rootViewController.uiViewController]
                        expect(navigator.viewControllers.ns) == [
                            rootViewController.uiViewController: rootViewController as Any,
                            presentedNavigator.uiViewController: presentedNavigator as Any,
                        ].ns
                    }
                        
                    context("quando feito dismiss pelo Navigator pai") {
                        beforeEach {
                            waitUntil { done in
                                navigator.dismiss(animated: false, completion: done)
                            }
                        }
                            
                        it("deve dispensar a view controller") {
                            expect(navigationController.viewControllers) == [rootViewController.uiViewController]
                            expect(navigationController.presentedViewController).to(beNil())
                        }
                            
                        it("deve remover a view controller apresentada da hierarquia do Navigator") {
                            expect(navigator.viewControllers.ns) == [
                                rootViewController.uiViewController: rootViewController,
                            ].ns
                        }
                    }
                        
                    context("quando feito dismiss pelo navigator apresentado") {
                        beforeEach {
                            waitUntil { done in
                                presentedNavigator.dismiss(animated: false, completion: done)
                            }
                        }
                            
                        it("deve dispensar a view controller") {
                            expect(navigationController.viewControllers) == [rootViewController.uiViewController]
                            expect(navigationController.presentedViewController).to(beNil())
                        }
                            
                        it("deve remover a view controller apresentada da hierarquia do Navigator") {
                            let vc = presentedNavigator.uiViewController
                            print(vc)
                            expect(navigator.viewControllers).to(haveCount(1))
                            expect(navigator.viewControllers.ns) == [
                                rootViewController.uiViewController: rootViewController,
                            ].ns
                        }
                    }
                }
            }
            
            context("quando instanciado sem root") {
                beforeEach {
                    navigator = Navigator(backIcon: Image(), closeIcon: Image())
                }
                
                it("deve ter hierarquia do Navigator vazia") {
                    expect(navigator.viewControllers).to(beEmpty())
                }
                
                it("deve ter a hierarquia do NavigationController vazia") {
                    expect(navigationController.viewControllers).to(beEmpty())
                }
                
                context("quando feito push and replace") {
                    beforeEach {
                        pushedViewController = DummyViewController()
                        waitUntil { done in
                            navigator.pushAndReplace(pushedViewController, animated: false, completion: done)
                        }
                    }
                    
                    it("deve exibir a view controller") {
                        expect(navigationController.topViewController) == pushedViewController.uiViewController
                    }
                    
                    it("deve adicionar a viewcontroller hierarquia do Navigator") {
                        expect(navigator.viewControllers.ns) == [
                            pushedViewController.uiViewController: pushedViewController,
                        ].ns
                    }
                    
                    it("deve adicionar a viewcontroller na hierarquia do Navigation Controller") {
                        expect(navigationController.viewControllers) == [
                            pushedViewController.uiViewController,
                        ]
                    }
                }
                context("quando alterados todos viewcontrollers") {
                    let viewControllers = [
                        DummyViewController(),
                        DummyViewController(),
                        DummyViewController(),
                        DummyViewController(),
                    ]
                    beforeEach {
                        navigator.setViewControllers(viewControllers, animated: false)
                    }
                    it("deve exibir a nova hierarquia") {
                        expect(navigationController.topViewController) == viewControllers.last!.uiViewController
                    }
                    
                    it("deve adicionar as viewcontrollers na hierarquia do Navigator") {
                        expect(navigator.viewControllers.ns) == Dictionary(uniqueKeysWithValues: viewControllers.map { ($0.uiViewController, $0) }).ns
                    }
                    
                    it("deve adicionar a viewcontroller na hierarquia do Navigation Controller") {
                        expect(navigationController.viewControllers) == viewControllers.map(\.uiViewController)
                    }
                    context("quando alterados novamente todos viewcontrollers") {
                        let newViewControllers = [
                            DummyViewController(),
                            DummyViewController(),
                        ]
                        beforeEach {
                            navigator.setViewControllers(newViewControllers, animated: false)
                        }
                        it("deve exibir a nova hierarquia") {
                            expect(navigationController.topViewController) == newViewControllers.last!.uiViewController
                        }
                        
                        it("deve adicionar as viewcontrollers na hierarquia do Navigator") {
                            expect(navigator.viewControllers.ns) == Dictionary(uniqueKeysWithValues: newViewControllers.map { ($0.uiViewController, $0) }).ns
                        }
                        
                        it("deve adicionar a viewcontroller na hierarquia do Navigation Controller") {
                            expect(navigationController.viewControllers) == newViewControllers.map(\.uiViewController)
                        }
                    }
                }
            }
        }
    }
}

private class DummyViewController: DeclarativeViewController {
    lazy var viewController = ViewController(view: view)
    let view = EmptyView().backgroundColor(.white)
}

import Foundation

public extension Dictionary {
    var ns: NSDictionary {
        self as NSDictionary
    }
}

public extension Array {
    var ns: NSArray {
        self as NSArray
    }
}

public extension Dictionary.Values {
    var ns: NSArray {
        Array(self).ns
    }
}
