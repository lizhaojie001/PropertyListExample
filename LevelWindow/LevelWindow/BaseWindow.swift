//
//  BaseWindow.swift
//  LevelWindow
//
//  Created by xdf_yanqing on 2019/3/27.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class BaseWindow: NSWindow {

}


class First: BaseWindow {
    convenience init() {
        self.init(contentViewController: NewViewController())
        self.backgroundColor = NSColor.red
    }
}

class Secound: BaseWindow {
    convenience init() {
        self.init(contentViewController: NewViewController())
        self.backgroundColor = NSColor.green

    }
}
