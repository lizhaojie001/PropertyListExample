//
//  AppDelegate.swift
//  tabView
//
//  Created by xdf_yanqing on 2020/6/22.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

@NSApplicationMain



class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController : SBSwindowController?
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
//        let vc1 = ViewController()
//        vc1.view.wantsLayer = true
//        vc1.view.layer?.backgroundColor = NSColor.red.cgColor
//        self.mainWindowController = SBSwindowController(vc1)
//        self.mainWindowController?.window?.orderFrontRegardless()
//        self.mainWindowController?.window?.makeKey()
//        let path = Bundle.main.path(forResource: "1", ofType: "pdf")
//        let a = FileManager.default.filesize(URL(fileURLWithPath:path!))
//        let error = NSError(domain: NSOSStatusErrorDomain, code: 101, userInfo: [NSLocalizedDescriptionKey : "错误"])
//        let alert = NSAlert(error: error)
//        alert.icon = NSImage(named: NSImage.applicationIconName)
//        alert.alertStyle = .critical
//        alert.runModal()
        
        getIvars()
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func getIvars() {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(NSTextField.self, &count)
        for i in 0 ..< count {
            let ivar = ivars![Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        free(ivars)
    }


}


extension FileManager {
    //M
    func filesize(_ url : URL) -> Int {
        do {
           let attr = try self.attributesOfItem(atPath: url.path)
            let size = attr[FileAttributeKey.size] as? CLong ?? 0
            debugPrint(size/1000/1000)
            return size
        } catch  {
            return 0
        }
    }
}


