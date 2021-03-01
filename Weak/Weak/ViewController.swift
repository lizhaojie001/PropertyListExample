//
//  ViewController.swift
//  Weak
//
//  Created by xdf_yanqing on 1/27/21.
//

import Cocoa

protocol PrivateProtocol : NSObject  {
     func swimm()
}

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    weak var delegate : PrivateProtocol?
    
    
    private var count = 0
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if count == 0 {
            let controller = BBViewController()
            self.delegate = controller.cat
            self.delegate?.swimm()
            let window = NSWindow(contentViewController: controller)
            window.makeKeyAndOrderFront(nil)
            self.count += 1
            address(d: &delegate)
         } else {
            address(d: &delegate)
         }
       
    }

    func address(  d :UnsafeMutablePointer<PrivateProtocol?>) {
        debugPrint(d.pointee)
    }
}


extension Cat : PrivateProtocol{
    func swimm() {
        debugPrint("猫学会了游泳游泳")
    }
 }
