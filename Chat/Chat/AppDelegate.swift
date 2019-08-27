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

    @IBOutlet weak var scrollview: NSScrollView!
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var window: NSWindow!
    var current :NSWindowController?
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        debugPrint((Bundle.main.executablePath as! NSString).deletingLastPathComponent)
        debugPrint((Bundle.main.bundlePath as! NSString).pathComponents)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func handleClickButton(_ sender: NSButton) {
//        self.current = ChatWindowController()
//        self.current?.showWindow(sender)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            NSWorkspace.shared.openFile(Bundle.main.bundlePath)
        }
    }
    
}

