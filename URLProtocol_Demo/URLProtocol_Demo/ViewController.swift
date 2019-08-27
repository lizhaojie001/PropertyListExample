//
//  ViewController.swift
//  URLProtocol_Demo
//
//  Created by xdf_yanqing on 2019/7/9.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    
    private var preferences:WKPreferences {
        let preferences = WKPreferences()
        
        preferences.setValue(true, forKey: "allowFileAccessFromFileURLs");
        
        #if DEBUG
        preferences.setValue(true, forKey: "developerExtrasEnabled");
        #endif
        
        //  preferences.setValue(false, forKey: "isWebSecurityEnabled")
        
        preferences.plugInsEnabled = true;
        preferences.javaEnabled = true;
        preferences.javaScriptCanOpenWindowsAutomatically = true;
        
        return preferences
    }
    lazy var webView:WKWebView = {
        let webView = WKWebView(frame: self.view.bounds, configuration: self.webConfig)
        webView.autoresizingMask = [.width,.height]
//        webView.navigationDelegate = self
//        webView.uiDelegate = self
        webView.wantsLayer = true
        return webView
    }()
    private var webConfig:WKWebViewConfiguration {
        let webConfig = WKWebViewConfiguration()
        webConfig.userContentController = WKUserContentController()
        webConfig.preferences = preferences
        return webConfig
    }
//    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.webView)
        self.webView.load(URLRequest(url: URL(string: "https://www.baidu.com/")!))
        // Do any additional setup after loading the view.
//        self.webView.value(forKeyPath: "browsingContextController")
        self.webView.navigationDelegate = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("webView 开始加载 url:\(webView.url.debugDescription)")

      
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("webView 加载完成 url:\(webView.url.debugDescription)")
      
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("webView 加载失败 url:\(webView.url.debugDescription) error:\(error)" )
 
    }
    
    @available(OSX 10.11, *)
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences : WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//    }
//
 
}
