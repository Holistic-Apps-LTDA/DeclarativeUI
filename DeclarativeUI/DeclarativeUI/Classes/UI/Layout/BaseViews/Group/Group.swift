import UIKit

public class Group: ViewGroup {
    public var views: [UIViewConvertible]
    public init(@UIViewBuilder views: () -> [UIViewConvertible]) {
        self.views = views()
    }
}
