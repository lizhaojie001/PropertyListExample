//
//  ViewController.swift
//  Core
//
//  Created by xdf_yanqing on 2019/11/21.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var loading : MutipleLoginLoadingView?
    override func viewDidLoad() {
        super.viewDidLoad()

        let  mutiple = MutipleLoginLoadingView(frame: NSRect(x: 200, y: 0, width: 120, height: 120))
        self.view.addSubview(mutiple)
        self.loading = mutiple
         // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 860, height: 570))
        self.view.wantsLayer = true
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        self.loading?.start()
//        self.loading?.isHidden = false
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

