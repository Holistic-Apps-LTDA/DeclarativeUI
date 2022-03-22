import UIKit
import WebKit

public extension WebView {
    class Delegate: NSObject, WKNavigationDelegate, WKUIDelegate {
        weak var webView: WebView?
        let events = Events()
        var interceptor: WebViewInterceptor?
        
        struct Events {
            let didCommitNavigation = Publisher<(webView: WKWebView, navigation: WKNavigation)>()
            let didFinishNavigation = Publisher<(webView: WKWebView, navigation: WKNavigation)>()
        }
        
        public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            events.didCommitNavigation.publish((webView: webView, navigation: navigation))
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            events.didFinishNavigation.publish((webView: webView, navigation: navigation))
        }
        
        public func webView(_ webView: WKWebView,
                            decidePolicyFor navigationAction: WKNavigationAction,
                            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let interceptor = interceptor else {
                return decisionHandler(.allow)
            }
            guard let webView = self.webView else {
                return assertionFailure("WebView must never be nil here, this is most likelly a programming error")
            }
            
            interceptor.interceptWebView(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler)
        }
        
        public func webView(_ webView: WKWebView,
                            createWebViewWith configuration: WKWebViewConfiguration,
                            for navigationAction: WKNavigationAction,
                            windowFeatures: WKWindowFeatures) -> WKWebView? {
            self.webView?.open(request: navigationAction.request)
            return nil
        }
    }
}
