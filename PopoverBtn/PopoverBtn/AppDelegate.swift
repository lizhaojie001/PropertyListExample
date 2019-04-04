//
//  AppDelegate.swift
//  PopoverBtn
//
//  Created by xdf_yanqing on 2019/3/14.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
  
    lazy var currentController: WindowController = {
        let windowController = WindowController()
        return windowController
    }()
    var mainController :NSWindowController?
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        debugPrint(notification)
    }
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let windowController = WindowController()

        windowController.showWindow(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

