//
//  ViewController.swift
//  PopoverBtn
//
//  Created by xdf_yanqing on 2019/3/14.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func loadView() {
        self.view = NSView.init(frame: NSMakeRect(0, 0, 200, 200))
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    
        let button = PopoverButton.init(tip: "123",controller: self)
        button.frame = NSMakeRect(20, 20, 100, 30)
        button.title = "456"
        self.view .addSubview(button)
        
        // Do any additional setup after loading the view.
    }

 
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

