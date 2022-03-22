import WebKit

public protocol WebViewInterceptor {
    func interceptWebView(_ webView: WebView,
                          decidePolicyFor navigationAction: WKNavigationAction,
                          decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
}

extension WKNavigationActionPolicy: CustomStringConvertible {
    public var description: String {
        switch self {
        case .cancel:
            return "cancel"
        case .allow:
            return "allow"
        case .download:
            return "download"
        @unknown default:
            return "unknown"
        }
    }
}
