import SwiftUI
    
@available(iOS 13.0, *)
public final class ViewControllerContainer: UIViewControllerRepresentable {
    public var view: UIViewControllerConvertible

    public init(view: UIViewControllerConvertible) {
        self.view = view
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        view.uiViewController
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

@available(iOS 13.0, *)
public final class ViewContainer: UIViewRepresentable {
    public typealias UIViewType = UIView
    
    public var view: UIViewConvertible

    public init(view: UIViewConvertible) {
        self.view = StackView(.vertical) {
            view
            Spacer(.flexible)
        }
    }
    
    public func makeUIView(context: Context) -> UIView {
        view.uiView
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
}

@available(iOS 13.0, *)
public final class ViewWrapper: UIViewRepresentable {
    public typealias UIViewType = UIView
    
    public var view: UIViewConvertible

    public init(view: UIViewConvertible) {
        self.view = view
    }
    
    public func makeUIView(context: Context) -> UIView {
        view.uiView
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
}

@available(iOS 13.0, *)
public extension UIViewConvertible {
    func toSwiftUIView() -> ViewWrapper {
        ViewWrapper(view: self)
    }
}

// MARK: Sample

/*
 import protocol SwiftUI.PreviewProvider
 import protocol SwiftUI.View
 @available(iOS 13.0.0, *)
 struct <#View#>_Previews: PreviewProvider {
     static var previews: some View {
         ViewControllerContainer(view: <#View#>())
     }
 }

 */
