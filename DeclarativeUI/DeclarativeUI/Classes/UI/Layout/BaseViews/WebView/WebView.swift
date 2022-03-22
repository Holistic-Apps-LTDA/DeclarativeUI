import UIKit
import WebKit

public protocol WebViewType {
    var webView: WebView { get }
}

public class WebView: WebViewType, DeclarativeView {
    public var webView: WebView { self }
    private let configuration = configure(WKWebViewConfiguration()) { configuration in
        configuration.allowsInlineMediaPlayback = true
        configuration.preferences = configure(WKPreferences()) { preferences in
            preferences.javaScriptEnabled = true
            preferences.javaScriptCanOpenWindowsAutomatically = true
        }
    }

    public lazy var rootView = BaseWebKitView(configuration: configuration)
    public let delegate = Delegate()
    fileprivate lazy var refreshControl = configure(UIRefreshControl()) {
        $0.addTarget(self, action: #selector(refreshAction),
                     for: .valueChanged)
    }

    public fileprivate(set) var defaultHeaders = [String: String?]()

    // MARK: Observables

    public lazy var progress = KVObservable(object: rootView, keyPath: \.estimatedProgress)
    public lazy var title = KVObservable(object: rootView, keyPath: \.title)
    public lazy var url = KVObservable(object: rootView, keyPath: \.url)
    
    public init() {
        delegate.webView = self
        rootView.navigationDelegate = delegate
        rootView.uiDelegate = delegate
        rootView.allowsLinkPreview = false
        pullToRefreshEnabled(true)
    }
}

public extension WebViewType {
    @discardableResult
    func open(url: String) -> Self {
        guard let url = URL(string: url) else { return self }
        return open(url: url)
    }
    
    @discardableResult
    func open(url: URL) -> Self {
        open(request: URLRequest(url: url))
    }
    
    @discardableResult
    func open(request: URLRequest) -> Self {
        var request = request
        for (header, value) in webView.defaultHeaders {
            request.setValue(value, forHTTPHeaderField: header)
        }
        webView.rootView.load(request)
        return self
    }
    
    @discardableResult
    func interceptor(_ interceptor: WebViewInterceptor) -> Self {
        webView.delegate.interceptor = interceptor
        return self
    }
    
    @discardableResult
    func defaultHeader(key: String, value: String?) -> Self {
        webView.defaultHeaders[key] = value
        return self
    }
    
    @discardableResult
    func defaultHeaders(_ headers: HeaderProvider) -> Self {
        webView.defaultHeaders.merge(headers.headers) { _, new in new }
        return self
    }
    
    @discardableResult
    func stopLoading() -> Self {
        webView.rootView.stopLoading()
        return self
    }
    
    @discardableResult
    func goBack() -> Self {
        webView.rootView.goBack()
        return self
    }
    
    @discardableResult
    func pullToRefreshEnabled(_ enabled: Bool) -> Self {
        webView.rootView.scrollView.refreshControl = enabled ? webView.refreshControl : nil
        return self
    }
}

public extension WebView {
    @discardableResult
    func showProgress(in navigator: Navigator) -> Self {
        showProgress(in: navigator.navigationBar.progressBar)
    }

    @discardableResult
    func showProgress(in progressView: ProgressView) -> Self {
        observe(progress) { `self`, progress in
            progressView.progress(progress)
            if progress >= 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                    guard self.progress.value >= 1 else { return }
                    progressView.progress(0)
                }
            }
        }
        return self
    }
}

private extension WebView {
    @objc func refreshAction() {
        webView.rootView.reload()
        webView.rootView.scrollView.refreshControl?.endRefreshing()
    }
}

public extension WebView {
    var canGoBack: Publisher<Bool> {
        delegate.events.didCommitNavigation
            .map { webView, _ in
                webView.canGoBack
            }
    }
}
