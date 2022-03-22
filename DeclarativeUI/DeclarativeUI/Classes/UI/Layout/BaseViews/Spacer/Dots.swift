import UIKit

public final class Dots: DeclarativeComponent {
    public var view = Image()
    
    public init(lines: Int, columns: Int, dotSize: Size = .extraSmall3, spacing: Size = .extraSmall, color: Color) {
        let vStack = StackView(.vertical)
            .padding(.uniform(.extraSmall2))
            .spacing(spacing)
        for _ in 1 ... lines {
            let hStack = StackView(.horizontal).spacing(spacing)
            vStack.addArrangedSubview(hStack)
            for _ in 1 ... columns {
                hStack.addArrangedSubview(makeDot(size: dotSize, color: color))
            }
        }
        let renderingView = UIView(frame: UIScreen.main.bounds)
        renderingView.layout.addSubview(vStack)
        vStack.uiView.layoutIfNeeded()
        view.image(vStack.asImage())
    }
}

private extension Dots {
    func makeDot(size: Size, color: Color) -> UIViewConvertible {
        EmptyView()
            .squared(size)
            .cornerRadius(size.value / 2)
            .backgroundColor(color)
    }
}

private extension UIViewConvertible {
    func asImage() -> UIImage {
        return UIGraphicsImageRenderer(bounds: uiView.bounds).image { rendererContext in
            uiView.layer.render(in: rendererContext.cgContext)
        }
    }
}

import protocol SwiftUI.PreviewProvider
import protocol SwiftUI.View
@available(iOS 13.0.0, *)
struct Dots_Previews: PreviewProvider {
    static var previews: some View {
        StackView(.vertical) {
            StackView(.horizontal) {
                Dots(lines: 10,
                     columns: 10,
                     dotSize: .extraSmall3,
                     color: .black)
                Spacer(.flexible)
            }
            Spacer(.flexible)
        }.toSwiftUIView()
    }
}
