//
//  CollectionViewItem.swift
//  CollectionView
//
//  Created by xdf_yanqing on 2019/8/27.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {
    override func loadView() {
        self.view = NSView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.red.cgColor
    }
    
}
