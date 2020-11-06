//
//  ViewController.swift
//  tabView
//
//  Created by xdf_yanqing on 2020/6/22.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func loadView() {
        self.view = NSView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 200)))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabVC = SBTabViewController()
        tabVC.tabStyle = .segmentedControlOnTop
        let vc1 = SBViewController()
        vc1.view.wantsLayer = true
        vc1.view.layer?.backgroundColor = NSColor.red.cgColor
        let item1 = NSTabViewItem(viewController: vc1)
        
        let vc2 = SBViewController()
        vc2.view.wantsLayer = true
        vc2.view.layer?.backgroundColor = NSColor.blue.cgColor
        let item2 = NSTabViewItem(viewController: vc2)
        
        tabVC.tabViewItems = [item1,item2]
        self.addChild(tabVC)
        tabVC.view.frame = NSRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 200, height: 200))
        self.view.addSubview(tabVC.view)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

