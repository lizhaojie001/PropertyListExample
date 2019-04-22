//
//  AppDelegate.swift
//  Button
//
//  Created by xdf_yanqing on 2019/4/10.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var button: NSButton!
    
    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.button.toolTip = "234567890"
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


class CustomButton: NSButton {
    
    override var toolTip: String?{
        didSet{
//            self.addToolTip(NSRect(x: 0, y: 0, width: 100, height: 30), owner: toolTip as Any, userData: nil)
        }
    }
}


