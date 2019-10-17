//
//  DudelView.swift
//  Art
//
//  Created by xdf_yanqing on 2019/9/29.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class DudelView: NSView{
    var drawables : [Drawable]?
    var delegate : DudelViewDelegate?
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        for item in drawables ?? [] {
            item.draw()
        }
        delegate?.drawTemporary()
        // Drawing code here.
    }
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        drawables = [Drawable]()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

protocol DudelViewDelegate {
    
    /// 临时画画
    func drawTemporary()
}
