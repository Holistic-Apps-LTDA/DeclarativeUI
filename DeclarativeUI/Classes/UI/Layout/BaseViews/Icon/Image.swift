import UIKit

public class Image: DeclarativeView {
    public var rootView: BaseImageView { imageView }
    private let imageView = BaseImageView()

    public init(_ image: UIImage? = nil) {
        self.image(image)
    }
    
    public init(_ image: Observable<UIImage>) {
        observe(image) { view, image in
            view.image(image)
        }
    }
    
    public init(_ image: Observable<UIImage?>) {
        observe(image) { view, image in
            view.image(image)
        }
    }
    
    public func image() -> UIImage? {
        return imageView.image
    }
    
    @discardableResult
    public func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        imageView.contentMode = contentMode
        return self
    }
    
    @discardableResult
    public func image(_ image: UIImage?) -> Self {
        imageView.image = image
        return self
    }
    
    @discardableResult
    func color(_ color: Color) -> Self {
        imageView.tintColor = color.value
        return self
    }
}
