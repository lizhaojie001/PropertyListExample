//
//  AppDelegate.swift
//  URLProtocol_Demo
//
//  Created by xdf_yanqing on 2019/7/9.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        URLProtocol.wk_registerScheme("http")
        URLProtocol.wk_registerScheme("https")
        URLProtocol.registerClass(MyURLProtocal.self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

