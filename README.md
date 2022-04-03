# DeclarativeUI
A library to develop UI declaratively in Swift.

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

## Requirements

| Platform | Minimum Swift Version | Installation | Status |
| --- | --- | --- | --- |
| iOS 11.0+ | 5.0 | [CocoaPods](#cocoapods), [Carthage](#carthage), [Swift Package Manager](#swift-package-manager) | Partially Tested |

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'DeclarativeUUI', '~> 0.0.7'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Holistic-Apps-LTDA/DeclarativeUI" ~> 0.0.7
```

```ogdl
carthage update --use-xcframeworks
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding DeclarativeUI as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/Holistic-Apps-LTDA/DeclarativeUI.git", .upToNextMajor(from: "0.0.7"))
]
```

## Usage

A demo app is available in the DemoApp folder for querying the usage of library components.

### ViewModel

```swift
enum DemoInteractionEvents {
    case rowSelect(DataObject)
    case iconTap
}

import DeclarativeUI

final class DemoViewModel: DeclarativeViewModel<Void, Error> {

    // MARK: Attributes

    let interactionEvents = Publisher<DemoInteractionEvents>()
    let data: DataObject
    
    // MARK: Life Cycle

    init(data: DataObject) {
        self.data = data
        super.init()
    }
}

```


### ViewController

```swift
import DeclarativeUI

final class DemoViewController: DeclarativeViewController {

    // MARK: Attributes

    public lazy var viewController = ViewController(view: view)
    private let viewModel: DemoViewModel
    
    private lazy var titlelLabel = Label(
        text: viewModel.data.title,
        style: .systemFont()
    )
    
    private lazy var detailLabel = Label(
        text: viewModel.data.detail
        style: .boldSystemFont()
    )

    private lazy var valueLabel = Label(
        text: viewModel.data.value
        style: .boldSystemFont()
    )

    private let icon = Image()
        .size(width: .medium, height: .medium)
        .image(viewModel.data.icon)
        
    private lazy var view = StackView(.vertical) {
        Spacer(.small)
        titlelLabel
        Spacer(.small)
        StackView(.horizontal) {
            icon
            detailLabel
        }.spacing(.extraSmall)
        .alignment(.leading)
        Spacer(.medium)
        valueLabel       
        Spacer(.flexible)
    }.padding(.uniform(.small))
    
    // MARK: Life Cycle

    public init(viewModel: DemoViewModel) {
        self.viewModel = viewModel
    }
}

```

### Component

```swift
import DeclarativeUI

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

```

### Preview

```swift
import SwiftUI
@available(iOS 13.0.0, *)
struct Pager_Previews: PreviewProvider {
    static var previews: some View {
        ViewContainer(view: pager)
            .previewDevice("iPhone 12")
    }

    static var pager = StackView(.vertical) {
        Spacer(.large)
        Pager(["Option 1", "Option 2", "Option 3"])
    }.padding(.horizontal(.medium))
}
```

### Coordinator

```swift
import DeclarativeUI

public final class DemoCoordinator: DeclarativeCoordinator {
        
    // MARK: Life Cycle
    
    public init() {
        super.init()
        start()
    }
    
    public func start() {
        navigateToDemo()
    }
    
    private func navigateToDemo() {
        let viewModel = DemoViewModel(data: DataObject())
        
        let viewController = DemoViewController(viewModel: viewModel)
            .navigationBarOptions([.back, .close])
            .navigationTitle("Title Navigation Bar")

        viewModel.interactionEvents.subscribe().onNext { event in
            switch event {
            case .rowSelect(let data):
                self.navigateToDemoDetail(data: data)
            case .iconOnTap:
                self.navigateToIconTap()
            }
        }.disposedBy(self)

        navigator.push(viewController)
    }
}
```
