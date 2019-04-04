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
        
        let imageView : NSImageView =  NSImageView.init(image: NSImage(named: "AppIcon")!)
        imageView.frame = NSMakeRect(50, 50, 100, 100)
        self.view.addSubview(imageView)
        
        let button = PopoverButton.init(tip: "123",controller: self)
        button.frame = NSMakeRect(20, 20, 100, 30)
        button.title = "456"
        self.view .addSubview(button)

        let but = NSButton(title: "test", target: self, action: #selector(showModalWinddow))
        but.frame = NSMakeRect(20,60, 100, 100)
        self.view.addSubview(but)
 
       
    }
    
    func test3()  {
        let process2 = Process.init()
        process2.launchPath = "/usr/bin/open"
        process2.arguments = ["/Users/xdf_yanqing/Downloads/云直播.dmg"]
        process2.launch()
//        NSApp.terminate(nil)
        
    }
    

    @objc func showModalWinddow() -> Void {
        let win = NSWindow()
        win.minSize = NSMakeSize(400, 400)
        win.center()
        NSApplication.shared.runModal(for: win)
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


class SurveyQuestion : NSObject {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
