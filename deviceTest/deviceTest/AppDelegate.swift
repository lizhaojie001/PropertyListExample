//
//  AppDelegate.swift
//  deviceTest
//
//  Created by xdf_yanqing on 2019/6/4.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import WebKit
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var webView: WebView!
    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        guard let path = Bundle.main.path(forResource: "index", ofType: "html") else { return  }
        let html = try? String(contentsOf: URL(fileURLWithPath: path), encoding: String.Encoding.utf8)
        self.webView.mainFrame.loadHTMLString(html, baseURL: URL(fileURLWithPath:Bundle.main.bundlePath))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

