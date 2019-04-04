//
//  AppDelegate.swift
//  TestSB
//
//  Created by xdf_yanqing on 2019/3/14.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var currentController: NSWindowController = {
        let windowController = WindowController()
        return windowController
    }()
    var windows : Array<NSWindowController> = Array()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        currentController.showWindow(nil)
        let icons =  Bundle.main.infoDictionary
        debugPrint(icons)
        let image = NSImage(named: "AppIcon")
        debugPrint(image?.name())
        
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

