//
//  AppDelegate.swift
//  TableView_demo
//
//  Created by xdf_yanqing on 2019/5/13.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var windowController: WindowController {
        let wc = WindowController()
        return wc
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    @IBAction func show(_ sender: Any) {
        windowController.showWindow(nil)
    
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

