//
//  ChatViewController.swift
//  Chat
//
//  Created by xdf_yanqing on 2019/4/19.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class ChatTableView: NSTableView {
    
}

class ChatViewController: NSViewController {

    var datas:[ChatItem] = [ChatItem]()
    
    override func loadView() {
   
        self.view = NSView.init(frame: NSRect.init(x: 0, y: 0, width: 500, height: 500))
       
    }
    lazy var tableView: ChatTableView = {
        let tableView = ChatTableView(frame: self.view.bounds)
        tableView.autoresizingMask = [.width,.height]
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("NSTableColumn"))
        tableView.addTableColumn(column)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        debugPrint(self.view.className)
        let tableView = ChatTableView.init(frame:self.view.bounds)
        tableView.autoresizingMask = [.width,.height]
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        reloadData()
    }
    
    func reloadData() {
      var i = 100
        while i > 0 {
            let item = ChatItem()
            item.isMySelf = true
            item.name = "wo"
            item.message = "wqertyuiop;['sdfghjkwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjklwqertyuiop;['sdfghjkll"
            datas.append(item)
            i = i - 1
        }
    }
    
}

extension ChatViewController : NSTableViewDelegate,NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }
    
    //提供数据
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let item = self.datas[row]
        return item
    }
    //设置自定义cell
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let cell = ChatItemCellView()
        cell.model = self.datas[row]
        return cell
    }
    
}
