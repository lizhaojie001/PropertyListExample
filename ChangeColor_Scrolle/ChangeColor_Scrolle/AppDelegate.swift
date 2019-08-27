//
//  AppDelegate.swift
//  ChangeColor_Scrolle
//
//  Created by xdf_yanqing on 2019/5/5.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var scroller: NSScroller!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.scroller.wantsLayer = true
//        self.scroller.layer?.backgroundColor = NSColor.red.cgColor
        for layer in self.scroller.layer!.sublayers! {
            debugPrint(layer)
            layer.backgroundColor = NSColor.green.cgColor
            
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    

}
 
