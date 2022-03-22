//import UIKit
//
//public class Loader: FlameComponent {
//    public let loader = UIActivityIndicatorView(style: .whiteLarge)
//    public lazy var view = StackView(.vertical) { loader }
//        .squared(.extraLarge5)
//        .backgroundColor(.black2)
//        .cornerRadius(.extraSmall)
//    
//    public init(loading: Publisher<Bool>) {
//        observe(loading) { view, loading in
//            loading ? view.loader.startAnimating() : view.loader.stopAnimating()
//            view.hidden(when: !loading)
//        }
//    }
//}
