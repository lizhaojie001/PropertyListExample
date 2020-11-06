//
//  ViewMiddel.swift
//  tabView
//
//  Created by xdf_yanqing on 2020/7/6.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewMiddel: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
       
        
        debugPrint(self.className)
    }
}
