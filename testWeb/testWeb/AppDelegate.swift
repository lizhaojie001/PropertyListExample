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
    
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var textTF: NSTextField!
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
       let config = self.webView.configuration
        config.mediaTypesRequiringUserActionForPlayback = .video
        let preference = config.preferences
        preference.setValue(true, forKey: "developerExtrasEnabled")
        guard let url = URL(string: "https://www.baidu.com") else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    @IBAction func load(_ sender: Any) {
        let string = self.textTF.stringValue
        
        
        self.imageView.image =   self.webshot(windowId: UInt32(self.window.windowNumber), self.webView.frame.size)
    }
    
    
    func webshot( windowId : UInt32 , _ size : NSSize) -> NSImage? {
        guard let image = CGWindowListCreateImage(CGRect.null, .optionIncludingWindow, windowId, .nominalResolution) else { return nil }
        let img = NSImage(cgImage: image, size: size)
        return img
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

