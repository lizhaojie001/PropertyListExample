//
//  Tool.swift
//  Art
//
//  Created by xdf_yanqing on 2019/9/29.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

protocol  Tool: NSObject {
    var delegate : ToolDelegate? { get set }
    func activate()
    func deactivate()
    func touchesBegan(touches : Set<NSTouch> , withEvent event: NSEvent)
    func touchesCancelled(touches : Set<NSTouch> , withEvent event: NSEvent)
    func touchesEnd(touches : Set<NSTouch> , withEvent event: NSEvent)
    func touchesMoved(touches : Set<NSTouch> , withEvent event: NSEvent)
}

protocol ToolDelegate {
    func addDrawable( item: Drawable)
    func viewForUserWithTool(tool : Tool) -> NSView
    func strokeColor() -> NSColor
    func fillColor() -> NSColor
}
