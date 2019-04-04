//
//  WindowController.swift
//  LevelWindow
//
//  Created by xdf_yanqing on 2019/3/27.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa


class Window: NSWindow {
    convenience init() {
        self.init()
        self.backgroundColor = NSColor.white
    }
}


class WindowController: NSWindowController {

    convenience init() {
        let window = Window(contentViewController: ViewController())
        self.init(window: window)
    }
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
