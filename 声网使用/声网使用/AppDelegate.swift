//
//  AppDelegate.swift
//  声网使用
//
//  Created by xdf_yanqing on 2019/3/28.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        debugPrint(CACurrentMediaTime())
        sleep(5)
        debugPrint(CACurrentMediaTime())

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

