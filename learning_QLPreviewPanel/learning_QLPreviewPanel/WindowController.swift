//
//  WindowController.swift
//  learning_QLPreviewPanel
//
//  Created by xdf_yanqing on 2019/4/8.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa


class WindowController: NSWindowController {
    convenience init() {
        let window = NSWindow.init(contentViewController: ViewController()  )
        self.init(window: window)
    }
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
