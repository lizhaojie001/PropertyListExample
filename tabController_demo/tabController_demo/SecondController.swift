//
//  SecondController.swift
//  tabView_Demo
//
//  Created by xdf_yanqing on 2020/5/6.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class SecondController: NSViewController {

    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 200))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.red.cgColor
        // Do view setup here.
        self.title = "2"
    }
    
}
