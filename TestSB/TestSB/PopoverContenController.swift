//
//  PopoverContenController.swift
//  PopoverBtn
//
//  Created by xdf_yanqing on 2019/3/14.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class PopoverContenController: NSViewController {

    override func loadView() {
        self.view = NSView.init(frame: NSMakeRect(0, 0, 100, 20))
    }
    public var tips : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let label  = NSTextField()
        label.frame  = self.view.frame
        self.view.addSubview(label)
        
    }
    
}
