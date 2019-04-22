//
//  AppDelegate.swift
//  Chat
//
//  Created by xdf_yanqing on 2019/4/19.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var current :NSWindowController?
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func handleClickButton(_ sender: NSButton) {
        self.current = ChatWindowController()
        self.current?.showWindow(sender)
    }
    
}

