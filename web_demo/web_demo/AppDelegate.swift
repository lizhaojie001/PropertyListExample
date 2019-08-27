//
//  AppDelegate.swift
//  web_demo
//
//  Created by xdf_yanqing on 2019/5/7.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import WebKit
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var path : String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
       return path + "/test.html"
    }
    lazy var wkWebView:WKWebView = {
        let preferences = WKPreferences()
        preferences.setValue(true, forKey: "allowFileAccessFromFileURLs");
        preferences.setValue(true, forKey: "developerExtrasEnabled");
        
        let webConfig = WKWebViewConfiguration()
        webConfig.userContentController = WKUserContentController()
        webConfig.preferences = preferences

        let webView = WKWebView(frame: NSMakeRect(200, 20, 500 , 500), configuration: webConfig)
//        webView.navigationDelegate = self
//        webView.uiDelegate = self
//        webView.wantsLayer = true
        return webView
    }()
    
    @IBOutlet weak var window: NSWindow!

//    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var webView: WebView!
    @IBOutlet weak var textView: NSScrollView!
    
    @IBAction func delete(_ sender: Any) {
        do {
            try FileManager.default.removeItem(atPath: self.path)
            let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
            try FileManager.default.removeItem(atPath:  path + "/tttt.jpg")
        }catch{}
       
    }
    @IBAction func addsubview(_ sender: Any) {
        guard let view = self.window.contentView else { return }
        view.addSubview(self.wkWebView)
    }
    @IBAction func setTodocument(_ sender: NSButton) {
        let test = Bundle.main.path(forResource: "test", ofType: "html")!
        let jpg = Bundle.main.path(forResource: "tttt", ofType: "jpg")!
            if let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first {
                let des = String(format: "%@/test.html", path)
                let jpgdes = path + "/tttt.jpg"
                if !FileManager.default.fileExists(atPath: des) {
                do {
                    try FileManager.default.copyItem(atPath: test, toPath: des)
                    try FileManager.default.copyItem(atPath: jpg, toPath: jpgdes)
                }catch{}
        }
        }
        
    }
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    

    }

    @IBAction func openDocument(_ sender: Any) {
        if let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first {
            NSWorkspace.shared.openFile(path)
        }
        
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func loadWeb(_ sender: Any) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first ?? ""
            let test = Bundle.main.path(forResource: "test", ofType: "html")!
            let url = URL.init(fileURLWithPath: self.path)
            let data = try Data.init(contentsOf: url)
            let string = String.init(data: data, encoding: String.Encoding.utf8)
            let basURL = URL.init(fileURLWithPath: path + "/tttt.jpg")
//            self.webView.mainFrame.loadHTMLString(string, baseURL: URL?.init(URL.init(fileURLWithPath: path)))
            self.wkWebView.loadHTMLString(try! String(contentsOf: url), baseURL: url.deletingLastPathComponent())
//            debugPrint(self.)
        } catch {
            debugPrint(error)
        }
    }
    
}

