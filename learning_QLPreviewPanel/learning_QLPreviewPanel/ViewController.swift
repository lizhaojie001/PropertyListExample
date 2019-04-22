//
//  ViewController.swift
//  learning_QLPreviewPanel
//
//  Created by xdf_yanqing on 2019/4/8.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import Quartz
class ViewController: NSViewController {
    
    override func loadView() {
        self.view = NSView.init(frame: NSRect(x: 200, y: 200, width: 500, height: 500))
    }
    private var previewItems : [QLPreviewItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension ViewController:QLPreviewPanelDataSource,QLPreviewPanelDelegate{
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return previewItems?.count ?? 0
    }
    
    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        let item : QLPreviewItem = (previewItems?[index])!
        return item
    }
}
