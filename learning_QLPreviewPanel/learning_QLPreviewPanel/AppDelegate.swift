//
//  AppDelegate.swift
//  learning_QLPreviewPanel
//
//  Created by xdf_yanqing on 2019/4/8.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import Quartz
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func handleButton(_ sender: NSButton) {
        
        let windowController = WindowController()
        windowController.showWindow(sender)
//        panel?.currentController = ViewController()
//        panel.release = self
//        panel.dataSource = self
//        let item1 = URL(fileURLWithPath: "/Users/xdf_yanqing/Downloads/io7-isome-icon-P.png") as QLPreviewItem
//        let item2 = URL(fileURLWithPath: "/Users/xdf_yanqing/Downloads/100.jpeg") as QLPreviewItem
//        previewItems = [item1,item2]
//        panel?.reloadData()
    }
    
}


