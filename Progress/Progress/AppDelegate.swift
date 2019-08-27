//
//  AppDelegate.swift
//  Progress
//
//  Created by macbook pro on 2019/6/4.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import Cocoa
import AVFoundation
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var indicator: NSProgressIndicator!

    @IBAction func sss(_ sender: NSButton) {
        switch sender.tag {
        case 10:
            self.indicator.doubleValue = 0.0
        case 20 :
            self.indicator.doubleValue = 0.5

        default:
            self.indicator.doubleValue = 1.0

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
//        [lighten setDefaults];
//        [lighten setValue:@1 forKey:@"inputBrightness"];
//        [self.indicator setContentFilters:[NSArray arrayWithObjects:lighten, nil]];
//
//        let lighten = CIFilter.init(name: "CIColorControls")
//        lighten?.setDefaults()
//        lighten?.setValue(0, forKey: "inputBrightness")
//        self.indicator.backgroundFilters = [lighten] as! [CIFilter]
//        self.indicator.appearance = NSAppearance(named: .darkAqua)
        self.indicator.controlTint = .graphiteControlTint
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
//        self.indicator.isBezeled = true
        let layer = CALayer()
        layer.backgroundColor = NSColor.gray.cgColor
//        self.indicator.layer = layer
//        self.indicator.controlTint
//        self.indicator.controlTint = NSControlTint.blueControlTint
//        self.window.contentView?.wantsLayer = true
//        self.window./
//        self.window.backgroundColor = NSColor.white
//        self.window.contentView?.canDrawSubviewsIntoLayer = true
//        self.window.contentView?.wantsLayer = true
//        self.window.contentView?.layer?.backgroundColor  = NSColor.white.cgColor
//        debugPrint(self.indicator.layer)

        guard let path = Bundle.main.path(forResource: "12222", ofType: "mp4") else { return  }
        let asaset = AVAsset(url: URL(fileURLWithPath: path))
        let matedata = asaset.metadata
        for data  in matedata {
            debugPrint(data.dataType)
        }

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

