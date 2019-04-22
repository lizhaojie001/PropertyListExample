//
//  ChatWindowController.swift
//  Chat
//
//  Created by xdf_yanqing on 2019/4/19.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class BaseWindow: NSWindow {
    
}

class ChatWindowController: NSWindowController {

    convenience init() {
        let chat = ChatViewController()
        let window = BaseWindow(contentViewController: chat)
        self.init(window: window)
    }
 
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
