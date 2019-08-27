//
//  WindowController.swift
//  TableView_demo
//
//  Created by xdf_yanqing on 2019/5/13.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

  
    
    convenience init() {
        let vc = ViewController()
        let window = NSWindow(contentViewController: vc)
        self.init(window:window)
    
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
