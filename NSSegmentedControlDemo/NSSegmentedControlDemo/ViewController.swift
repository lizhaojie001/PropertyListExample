//
//  ViewController.swift
//  NSSegmentedControlDemo
//
//  Created by xdf_yanqing on 2020/8/25.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private lazy var textLabel :NSTextField = {
        let label = NSTextField(frame: NSRect.zero)
        label.lineBreakMode = NSLineBreakMode.byClipping
        label.alignment = .center
        label.isEditable = false
        label.isSelectable = false
        label.drawsBackground = true
        label.backgroundColor = NSColor.clear
        label.isBordered = false
        label.maximumNumberOfLines = 0
        label.stringValue = "textLabel"
        return label
    }()
    
    func setupView() {
        let segment = NSSegmentedControl(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 200, height: 60)))
        segment.segmentCount = 1
        segment.setImage(NSImage(named: "bg_other_slider-number"), forSegment: 0)
        segment.setImageScaling(.scaleProportionallyUpOrDown, forSegment: 0)
        self.view.addSubview(segment)
    }
   @objc func test(_ btn : Any) {
        debugPrint(btn)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

