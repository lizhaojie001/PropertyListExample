//
//  ChatItemCellView.swift
//  Chat
//
//  Created by xdf_yanqing on 2019/4/19.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class ChatItemCellView: NSTableRowView {

    var model : ChatItem? = nil
    lazy var nameLabel: NSTextField = {
        let label = NSTextField()
        label.lineBreakMode = NSLineBreakMode.byClipping
        label.isEditable = false
        label.isSelectable = false
        label.drawsBackground = true
        label.backgroundColor = NSColor.clear
        label.isBordered = false
        label.textColor = NSColor.white
        return label
    }()
    lazy var chatMessageTV: NSTextView = {
        let textView = NSTextView()
        textView.isEditable = false
        textView.isRichText = true
        return textView
    }()
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
