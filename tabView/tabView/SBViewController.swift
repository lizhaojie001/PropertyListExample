//
//  SBViewController.swift
//  tabView
//
//  Created by xdf_yanqing on 2020/6/22.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class SBViewController: NSViewController {
    override func loadView() {
           self.view = NSView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 400, height: 400)))
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let bottom = ViewBottom(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 200)))
        bottom.wantsLayer = true
        bottom.layer?.backgroundColor = NSColor.red.cgColor
        self.view.addSubview(bottom)
        let midel = ViewMiddel(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 100 , height: 100)))
        midel.wantsLayer = true
        midel.layer?.backgroundColor = NSColor.blue.cgColor
        bottom.addSubview(midel)
        
        let top = ViewTop(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 50 , height: 50)))
        top.wantsLayer = true
        top.layer?.backgroundColor = NSColor.white.cgColor
        midel.addSubview(top)

    }
    
}
