//
//  BBViewController.swift
//  Weak
//
//  Created by xdf_yanqing on 1/27/21.
//

import Cocoa

class BBViewController: NSViewController {
    
    lazy var cat : Cat = {
        return Cat()
    }()
    override func loadView() {
        self.view = NSView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 400, height: 400)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        cat.eat()
    }
    
    deinit {
        defer {
            debugPrint(self.cat)
        }
        debugPrint("1234567890")
    }
    
    
}


class Cat: NSObject {
    func eat() {
        debugPrint("eat fish")
    }
    
   
}
