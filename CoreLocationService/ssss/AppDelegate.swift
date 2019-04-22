//
//  AppDelegate.swift
//  ssss
//
//  Created by xdf_yanqing on 2019/4/18.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var Menu: NSMenuItem!
    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.Menu.title = "123"
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

