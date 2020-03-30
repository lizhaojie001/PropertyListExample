
//
//  WebViewController.swift
//  WebView
//
//  Created by xdf_yanqing on 2019/10/10.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
//        let constrains = NSLayoutConstraint.constraints(withVisualFormat: " H:|-50-[webView]-50-|", options: 0, metrics: <#T##[String : Any]?#>, views: <#T##[String : Any]#>)
//        H:|-50-[webView]-50-|
        self.webView.load(URLRequest(url: URL(string: "https://www.baidu.com/")!))
        
    }
    
}
