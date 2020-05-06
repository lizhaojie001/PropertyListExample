//
//  FirstController.swift
//  tabView_Demo
//
//  Created by xdf_yanqing on 2020/5/6.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class FirstController: NSViewController {


    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 200))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.green.cgColor
        self.title = "1"
        // Do view setup here.
    }
    
    
}
