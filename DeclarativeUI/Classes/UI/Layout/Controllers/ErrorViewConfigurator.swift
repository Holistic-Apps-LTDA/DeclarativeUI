//import Foundation
//import UIKit
//
//public struct ErrorViewConfigurator {
//    
//    var icon: FontIcon
//    var title: String
//    var subtitle: NSAttributedString
//    var body: String
//    var actions: [ErrorAction]
//    
//    public init(icon: FontIcon = FontIcon.Kit.pix,
//                title: String = "Ops,\nocorreu um erro",
//                subtitle: String = "Não se preocupe, iremos trabalhar pra\nresolver. Por favor, tente novamente!",
//                body: String = "Se o erro persistir, entre em contato\nconosco através do nosso chat:",
//                actions: [ErrorAction] = [ErrorAction(title: "Falar no chat com a Gi",
//                                                      buttonStyle: .light,
//                                                      action: nil),
//                                          ErrorAction(title: "Tentar novamente",
//                                                      buttonStyle: .dark,
//                                                      action: nil)]) {
//        self.icon = icon
//        self.title = title
//        self.subtitle = subtitle.style(.body1(fontType: .regular, color: .support100))
//        self.body = body
//        self.actions = actions
//    }
//    
//    public init(icon: FontIcon = Icons.tired,
//                title: String = "Ops,\nocorreu um erro",
//                subtitle: NSAttributedString,
//                body: String = "Se o erro persistir, entre em contato\nconosco através do nosso chat:",
//                actions: [ErrorAction] = [ErrorAction(title: "Falar no chat com a Gi",
//                                                      buttonStyle: .light,
//                                                      action: nil),
//                                          ErrorAction(title: "Tentar novamente",
//                                                      buttonStyle: .dark,
//                                                      action: nil)]) {
//        self.icon = icon
//        self.title = title
//        self.subtitle = subtitle
//        self.body = body
//        self.actions = actions
//    }
//}
//
//public struct ErrorAction {
//    var title: String
//    var buttonStyle: Button.Style
//    var action: (() -> Void)?
//    
//    public init(title: String,
//                buttonStyle: Button.Style,
//                action: (() -> Void)?) {
//        
//        self.title = title
//        self.buttonStyle = buttonStyle
//        self.action = action
//    }
//}
//
//public extension ErrorViewConfigurator {
//    static let defaultError = ErrorViewConfigurator(
//        icon: FontIcon.Kit.pix,
//        title: "Ops,\nocorreu um erro",
//        subtitle: "Não se preocupe, iremos trabalhar pra\nresolver. Por favor, tente novamente!",
//        body: "Se o erro persistir, entre em contato\nconosco através do nosso chat:",
//        actions: [.init(title: "Falar no chat com a Gi",
//                        buttonStyle: .light,
//                        action: nil),
//                  .init(title: "Tentar novamente",
//                        buttonStyle: .dark,
//                        action: nil)])
//            
//    static func standard(onTapRetry: @escaping () -> Void,
//                         onTapChat: (() -> Void)? = nil) -> ErrorViewConfigurator {
//        .init(actions: [.init(title: "Falar no chat com a Gi",
//                              buttonStyle: .outlineLight) { onTapChat?() },
//                        .init(title: "Tentar novamente",
//                              buttonStyle: .light) { onTapRetry()}])
//    }
//}
