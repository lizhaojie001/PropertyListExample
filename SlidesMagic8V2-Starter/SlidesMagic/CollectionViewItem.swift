//
//  CollectionViewItem.swift
//  SlidesMagic
//
//  Created by xdf_yanqing on 2020/5/6.
//  Copyright © 2020 razeware. All rights reserved.
//

import Cocoa
import SnapKit
class CollectionViewItem: NSCollectionViewItem {
  
  static let identifier = NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem")
  
  lazy var imgView : NSImageView = {
    let image = NSImageView(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 50)))
    return image
  }()
  
  lazy var textTF : NSTextField = {
    let tf = NSTextField(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 20)))
    return tf
  }()
  
  var imageFile : ImageFile? {
    didSet{
      if let imageF = imageFile {
        imgView.image = imageF.thumbnail
        textField?.stringValue = imageF.fileName
      } else {
        imgView.image = nil
        textField?.stringValue = ""
      }
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
      view.wantsLayer = true
      view.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
  
 func setupView() {
  
  }
    
}
