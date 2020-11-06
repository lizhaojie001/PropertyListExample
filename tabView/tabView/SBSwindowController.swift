//
//  SBSwindowController.swift
//  tabView
//
//  Created by xdf_yanqing on 2020/6/22.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class SBSwindowController: NSWindowController {
 
    convenience init(_ controller : NSViewController) {
        let window = NSWindow(contentViewController: controller)
        self.init(window:window)

    }
 
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
