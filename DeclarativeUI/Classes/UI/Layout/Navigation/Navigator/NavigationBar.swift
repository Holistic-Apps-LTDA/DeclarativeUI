import UIKit

public class NavigationBar: DeclarativeComponent {
    private let title = Label(style: .systemFont())
        .alignment(.center)
        .numberOfLines(2)
    
    let backButton: Image
    let closeButton: Image
    let rightButton = Image()
        .height(.medium)
        .width(.medium)
        .contentMode(.scaleAspectFill)

    let leftButton = Image()
        .height(.medium)
        .width(.medium)
        .contentMode(.scaleAspectFill)

    public let progressBar = ProgressView()
        .height(.extraSmall4)
        .style(.bar)
    
    public lazy var view = ContainerView {
        StackView(.vertical) {
            navigationView
            progressBar
        }
        .height(.greaterOrEqual(.extraLarge3))
    }
        
    private lazy var navigationView = StackView(.horizontal) {
        leftView
        Spacer(.extraSmall3)
        title.layout {
            $0.centerHorizontallyInSuperview()
        }
        Spacer(.extraSmall3)
        rightView
    }
    .padding(.horizontal(.small) + .vertical(.extraSmall))
    
    private lazy var leftView = StackView(.horizontal) {
        backButton
        leftButton.hidden()
    }.alignment(.top)
    
    private lazy var rightView = StackView(.horizontal) {
        rightButton.hidden()
        closeButton
    }.alignment(.top)
    
    public init(title: String = "",
                backIcon: Image,
                closeIcon: Image) {
        self.backButton = backIcon
            .height(.medium)
            .width(.medium)
            .contentMode(.scaleAspectFill)
        
        self.closeButton = closeIcon
            .height(.medium)
            .width(.medium)
            .contentMode(.scaleAspectFill)

        self.title(title)
    }
    
    @discardableResult
    public func title(_ value: String?, animated: Bool = true) -> Self {
        title.text(value ?? "", animated: animated)
        return self
    }
    
    @discardableResult
    public func navigationOptions(_ options: NavigationOptions) -> Self {
        backButton.hidden(when: options.contains(.back) == false)
        closeButton.hidden(when: options.contains(.close) == false)
        return self
    }
    
    @discardableResult
    public func style(_ style: NavigationBarStyle) -> Self {
        title.style(.systemFont())
        closeButton.color(style.tintColor)
        backButton.color(style.tintColor)
        view.backgroundColor(style.backgroundColor)
        return self
    }
    
    @discardableResult
    public func rightButton(_ button: CustomButton?) -> Self {
        setupCustomButton(button: rightButton, customButton: button)
    }
    
    @discardableResult
    public func leftButton(_ button: CustomButton?) -> Self {
        setupCustomButton(button: leftButton, customButton: button)
    }
    
    private func setupCustomButton(button: Image,  customButton: CustomButton?) -> Self {
        button.disposeBag.disposeAll()
        guard let customButton = customButton else {
            button.hidden()
            return self
        }
        button.image((customButton.icon.image()))
        button.onTap(customButton.action)
        button.hidden(when: customButton.isHidden)
        return self
    }
}

public extension NavigationBar {
    class CustomButton {
        public var icon: Image
        public var isHidden: Publisher<Bool>
        public var action: () -> Void
        
        public init(icon: Image,
                    isHidden: Publisher<Bool>,
                    action: @escaping () -> Void) {
            self.icon = icon
            self.isHidden = isHidden
            self.action = action
        }
    }
}

public extension NavigationBar {
    var isTransparent: Bool {
        view.rootView.backgroundColor?.rgba.alpha == 0
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct DeclarativeNavigation_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI.Group {
            wrap(NavigationBar(title: "Sem botões", backIcon: Image(), closeIcon: Image())
                .navigationOptions(.none))
            wrap(NavigationBar(title: "Com back button",
                               backIcon: Image(Icon(Icons.back, size: .medium, color: .black).asImage()),
                              closeIcon: Image())
                .navigationOptions(.back))
            wrap(NavigationBar(title: "Com close button",
                              backIcon: Image(),
                              closeIcon: Image(Icon(Icons.close, size: .medium, color: .black).asImage()))
                .navigationOptions(.close))
            wrap(NavigationBar(title: "Com back e close",
                              backIcon: Image(Icon(Icons.back, size: .medium, color: .black).asImage()),
                              closeIcon: Image(Icon(Icons.close, size: .medium, color: .black).asImage()))
                .navigationOptions([.back, .close]))
            wrap(NavigationBar(title: "Um título muito grandão de verdade que pode crescer mais, porem nunca passa de 2 linhas",
                               backIcon: Image(Icon(Icons.back, size: .medium, color: .black).asImage()),
                               closeIcon: Image(Icon(Icons.close, size: .medium, color: .black).asImage()))
                .navigationOptions([.back, .close]))
        }
    }

    static func wrap(_ view: NavigationBar) -> some View {
        ViewContainer(view: view)
            .previewLayout(.fixed(width: 320, height: 170))
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
