//
//  AppDelegate.swift
//  testWeb
//
//  Created by macbook pro on 2020/4/20.
//  Copyright © 2020 macbook pro. All rights reserved.
//

import Cocoa
import WebKit
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var textTF: NSTextField!
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
       let config = self.webView.configuration
        config.mediaTypesRequiringUserActionForPlayback = .video
        let preference = config.preferences
        preference.setValue(true, forKey: "developerExtrasEnabled")
    }
    @IBAction func load(_ sender: Any) {
        let string = self.textTF.stringValue
        guard let url = URL(string: string) else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

