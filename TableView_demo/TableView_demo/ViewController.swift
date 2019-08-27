//
//  ViewController.swift
//  TableView_demo
//
//  Created by xdf_yanqing on 2019/5/13.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 200))
    }
    lazy var tableView: NSTableView = {
        let tableview = NSTableView(frame: self.view.bounds)
        tableview.autoresizingMask  = [.width , .height]
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let tableColumn = NSTableColumn.init(identifier: NSUserInterfaceItemIdentifier("tableColumn"))
        tableView.addTableColumn(tableColumn)
        self.view.addSubview(tableView)
        
        let path = Bundle.main.path(forResource: "info", ofType: "plist")
        guard let zipPath = Bundle.main.path(forResource: "web", ofType: "zip") else { return  }
        let attr  = try? FileManager.default.attributesOfItem(atPath: zipPath)
        debugPrint(attr?[FileAttributeKey.creationDate] is Date)
    }
    
    
    
}

extension ViewController : NSTableViewDataSource ,NSTableViewDelegate{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = NSTableCellView()
        cell.textField?.stringValue = "12345"
        return cell
    }
}
