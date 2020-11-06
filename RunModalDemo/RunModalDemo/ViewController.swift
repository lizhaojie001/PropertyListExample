//
//  ViewController.swift
//  RunModalDemo
//
//  Created by xdf_yanqing on 2020/9/3.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var  timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = Timer(timeInterval: 1, repeats: true) { (timer) in
            DispatchQueue.main.async {
                debugPrint("123456789")
             }
            debugPrint("123456789")

        }
        debugPrint(String(format:"%p",(RunLoop.current)))
        RunLoop.current.add(timer, forMode: .common)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func show(_ sender: NSButton) {
//        DispatchQueue.main.async {
//            let window = NSWindow(contentViewController: PPController())
//            NSApp.runModal(for: window)
//        }
        
    }
  

}

class PPController: NSViewController {
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 200))
    }
     
    var timer : Timer?
    
    override func viewDidAppear() {
        super.viewDidAppear()
        debugPrint(String(format:"%p",(RunLoop.current)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
//            debugPrint("123")
//        })
 
    }
    deinit {
          debugPrint(#function)
      }
}
 
