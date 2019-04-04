//
//  PopoverButton.swift
//  PopoverButton
//
//  Created by xdf_yanqing on 2019/3/14.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class PopoverButton: NSButton {
 private   var mouseTrackingArea :NSTrackingArea?
    weak var controller : NSViewController?
    private var tip :String?
    lazy var popover: NSPopover = {
        let pop = NSPopover()
        pop.contentViewController =  PopoverContenController()
        pop.behavior = .semitransient
        pop.animates = false
        return pop
    }()

    convenience init( tip :String ,controller:NSViewController) {
        self.init()
    self.tip = tip
        if let contentVc = self.popover.contentViewController as? PopoverContenController {
            contentVc.tips = tip
        }
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }
    override func updateTrackingAreas() {
        if mouseTrackingArea != nil {
            removeTrackingArea(mouseTrackingArea!)
        }
        
        mouseTrackingArea = NSTrackingArea.init(rect: self.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        addTrackingArea(mouseTrackingArea!)
    }
    
    override func mouseEntered(with event: NSEvent) {
        let rect = NSRect.init(x: self.frame.size.width*0.5, y: 0, width: 0  , height: 20)
        popover.show(relativeTo: rect, of: self, preferredEdge: .minY)
    }
    
    override func mouseExited(with event: NSEvent) {
        popover.close()
    }
}


class  Person{
}
extension Person{
   @objc func eat(){
        print("eat some food")
    }
}


class student: Person {

}

extension student{
    override func eat() {
        
    }
}
