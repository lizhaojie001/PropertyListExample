//
//  ViewController.swift
//  LevelWindow
//
//  Created by xdf_yanqing on 2019/3/27.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa


class View: NSView {
    convenience init() {
        self.init()
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
    }
}

class ViewController: NSViewController {

    override func loadView() {
        self.view = View.init(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 300)))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
       let button = NSButton.init(frame: NSRect(origin: CGPoint.init(x: 20, y: 20), size: CGSize(width: 40, height: 40)))
        button.target = self
        button.action = #selector(addWindow)
        self.view.addSubview(button)
        
        let button1 = NSButton.init(frame: NSRect(origin: CGPoint.init(x: 80, y: 20), size: CGSize(width: 40, height: 40)))
        button1.target = self
        button1.action = #selector(switchLevel)
        self.view.addSubview(button1)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeState(noti:)), name: NSWindow.didExposeNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(changeState(noti:)), name: NSWindow.didBecomeKeyNotification, object: nil)
    }
    
    
    
    @objc func changeState(noti:NSNotification){
        debugPrint(noti.object as Any)
        if let object : NSWindow = noti.object as? NSWindow , object is First || object is Secound {
             self.view.window?.bringSubwindowToFront(window: object)
        }
    }
    
    
   @objc func addWindow()  {
        let first = First()
        self.view.window?.addChildWindow(first, ordered: NSWindow.OrderingMode.above)
        first.makeKey()
        let second = Secound()
        self.view.window?.addChildWindow(second, ordered: NSWindow.OrderingMode.above)
        second.makeKey()
    }
    
   @objc func switchLevel()  {
    let second = self.view.window?.childWindows?.first(where: { (wd) -> Bool in
        return wd is First
    })
    second?.level = NSWindow.Level.init(1)
    
    }
    
}
