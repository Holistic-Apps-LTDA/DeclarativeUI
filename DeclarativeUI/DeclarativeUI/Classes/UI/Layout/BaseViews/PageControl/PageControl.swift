import UIKit

public class PageControl: DeclarativeView {
    public let rootView = BasePageControl()
    public let currentPage = Publisher<Int>()

    public init(style: Style = .default) {
        if #available(iOS 14.0, *) {
            rootView.backgroundStyle = .minimal
            rootView.allowsContinuousInteraction = false
        }
        currentPageIndicatorColor(style.currentPageIndicatorColor)
        pageIndicatorColor(style.pageIndicatorColor)
    }

    @discardableResult
    public func currentPage(_ page: Int) -> Self {
        rootView.currentPage = page
        currentPage.publish((page))
        return self
    }

    @discardableResult
    public func numberOfPages(_ pages: Int) -> Self {
        rootView.numberOfPages = pages
        return self
    }

    @discardableResult
    public func currentPageIndicatorColor(_ color: Color) -> Self {
        rootView.currentPageIndicatorTintColor = color.value
        return self
    }

    @discardableResult
    public func pageIndicatorColor(_ color: Color) -> Self {
        rootView.pageIndicatorTintColor = color.value
        return self
    }
}

public extension PageControl {
    struct Style {
        var currentPageIndicatorColor: Color
        var pageIndicatorColor: Color
        
        public static let `default` = Style(currentPageIndicatorColor: .black, pageIndicatorColor: .black)
    }
}
