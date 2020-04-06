//
//  ViewController.swift
//  SyncCodeSnippets
//
//  Created by macbook pro on 2020/4/4.
//  Copyright © 2020 macbook pro. All rights reserved.
//

import Cocoa
let iCloudId = "iCloud.com.yanqing.SyncCodeSnippets"
class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(getUbiquityContauneURLWithFileName("123"))
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    func getUbiquityContauneURLWithFileName(_ fileName : String) -> URL? {
        guard let url = FileManager.default.url(forUbiquityContainerIdentifier: iCloudId) else {
            return nil
        }
        
        var file = url.appendingPathComponent("Documents")
        file = file.appendingPathComponent(fileName)
        return file
    }
    
}

