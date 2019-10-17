//
//  CollectionViewItem.swift
//  CollectionView
//
//  Created by xdf_yanqing on 2019/8/27.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import SnapKit
class CollectionViewItem: NSCollectionViewItem {
    override func loadView() {
        self.view = NSView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50)))
    }
    
    var app : App? {
        didSet{
            guard let path = app?.iconPath else { return }
            guard let image = NSImage(contentsOfFile: path) else { return }
            self.appIcon.image = image
        }
    }
    
    lazy var appIcon: NSImageView = {
        let imageView = NSImageView(frame: self.view.bounds)
        imageView.autoresizingMask = [.width , .height]
        return imageView
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.red.cgColor
        
        setupView()
    }
    
    func setupView()  {
        view.addSubview(appIcon)
        appIcon.snp.makeConstraints { (maker) in
            maker.edges.equalTo(NSEdgeInsetsZero)
        }
        
    }
    
}
