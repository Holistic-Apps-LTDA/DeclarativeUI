import UIKit

public class Pager: DeclarativeComponent {
    public lazy var view = stackView
    
    private lazy var stackView = StackView(.horizontal)
        .distribution(.fillEqually)
        .alignment(.center)
        .spacing(.zero)
        
    private var buttons = [Page]()
    private var selectedIndex = Publisher<Int>()
    private let initialIndexSelected: Int
    
    public init(_ options: [String],
                indexSelected: Int = 0) {
        initialIndexSelected = indexSelected
        options.enumerated().forEach { index, value in
            let button = Page(value)
                .onTap { [weak self] in
                    self?.selectedIndex.publish(index)
                }
            if index == initialIndexSelected {
                button.selectLayout()
            } else {
                button.normalLayout()
            }
            buttons.append(button)
        }
        stackView.update {
            buttons as [UIViewConvertible]
        }
        
        bindSelectedIndex()
    }
    
    private func bindSelectedIndex() {
        observe(selectedIndex) { [stackView, buttons] vc, indexSelected in
            vc.buttons.enumerated().forEach { index, button in
                if index == indexSelected {
                    button.selectLayout()
                } else {
                    button.normalLayout()
                }
            }
            stackView.update {
                buttons as [UIViewConvertible]
            }
        }
    }
    
    @discardableResult
    public func didChangeValue(_ action: @escaping (Int?) -> Void) -> Self {
        selectedIndex.subscribe().onNext { _, value in
            action(value)
        }.disposedBy(self)
        return self
    }
}

private class Page: DeclarativeComponent {
    public lazy var view = ContainerView { stackView }
    private let title = Label(style: .systemFont())
    private let line = EmptyView()
        .backgroundColor(.white)
        .height(.extraSmall2)
        .cornerRadius(.extraSmall3)
    
    private lazy var stackView = StackView(.vertical) {
        title
            .alignment(.center)
        Spacer(.extraSmall)
        line
    }.distribution(.fill)

    public init(_ title: String) {
        self.title.text(title)
    }
    
    public func selectLayout() {
        title.style(.boldSystemFont())
        line.backgroundColor(.black)
    }
    
    public func normalLayout() {
        title.style(.systemFont())
        line.backgroundColor(.white)
    }
}

import SwiftUI
@available(iOS 13.0.0, *)
struct Pager_Previews: PreviewProvider {
    static var previews: some View {
        ViewContainer(view: pager)
            .previewDevice("iPhone SE (2nd generation)")
    }

    static var pager = StackView(.vertical) {
        Spacer(.large)
        Pager(["Opcao 1", "Opcao 2", "Opcao 3"])
    }.padding(.horizontal(.medium))
}
