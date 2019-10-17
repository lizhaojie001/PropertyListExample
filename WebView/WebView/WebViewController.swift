
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
        self.webView.load(URLRequest(url: URL(string: "https://www.baidu.com/")!))
        
    }
    
}
