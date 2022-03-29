import UIKit


import SwiftUI
@available(iOS 13.0.0, *)
struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
//        ViewContainer(view: view)
        let scrollView = ScrollView(.horizontal) {
            Image(Icon(Icons.close, size: .extraLarge2, color: .white).asImage())
                .squared(.extraLarge7)
                .contentMode(.scaleAspectFit)
        }
        let viewController = ViewController(view: scrollView)
        return ViewControllerContainer(view: viewController)
    }
}

