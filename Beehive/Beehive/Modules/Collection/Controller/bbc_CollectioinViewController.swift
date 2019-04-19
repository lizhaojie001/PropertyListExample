//
//  bbc_CollectioinViewController.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/7.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_CollectioinViewController: ViewController {

    var viewModel : bbc_CollectionViewModel?
    lazy var tableView : UITableView  = {
        let table = UITableView.init(frame: self.view.frame, style: UITableView.Style.plain)
        table.allowsMultipleSelection = false
        table.allowsMultipleSelectionDuringEditing = true
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.tableFooterView = UIView()
        table.backgroundColor = UIColor.clear
        table.backgroundView?.backgroundColor = UIColor.clear
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setupView() {
        self.navigationItem.title = "SHOPCAR"
        self.view.layer.contents = UIImage(named: "369068")?.cgImage
//        navigationItem.rightBarButtonItem = editButtonItem
        view.layoutMargins.left = 32
        view.addSubview(tableView)
        viewModel = bbc_CollectionViewModel.init(tableView)
        viewModel?.getshopcarList()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
