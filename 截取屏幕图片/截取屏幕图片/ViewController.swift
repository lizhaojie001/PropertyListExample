//
//  ViewController.swift
//  截取屏幕图片
//
//  Created by xdf_yanqing on 12/7/20.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
     @IBOutlet weak var imageView: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func snap(_ sender: Any) {
        if let image = getImage(with: 0) {
            let img = NSImage(cgImage: image, size: self.view.bounds.size)
            self.imageView.image = img
            do {
                try  img.tiffRepresentation?.write(to: URL(fileURLWithPath:"/Users/xdf_yanqing/Desktop/\(Date()).png"))
            } catch  {
                debugPrint(error)
            }
        }
        
    }
    
    private func getImage(with windowId:NSNumber) -> CGImage? {
        var cgWindowId = kCGNullWindowID //录制全屏
        var image:CGImage? = nil
        if windowId != 0 {
            cgWindowId = windowId.uint32Value
            image = CGWindowListCreateImage(CGRect.null, CGWindowListOption.optionIncludingWindow, cgWindowId, CGWindowImageOption.nominalResolution)
        } else {
            let screens = NSScreen.screens
            if var newFrame = NSScreen.main?.frame {
                newFrame.origin.y = (screens[0].frame.maxY - newFrame.maxY)
                image = CGWindowListCreateImage(newFrame, CGWindowListOption.optionOnScreenOnly, cgWindowId, CGWindowImageOption.nominalResolution)
            }
        }
        return image
    }
}

