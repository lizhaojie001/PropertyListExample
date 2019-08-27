//
//  bbc_MeViewController.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/7.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_MeViewController: ViewController {
    lazy var tableView : UITableView  = {
        let table = UITableView.init(frame: self.view.frame, style: UITableView.Style.grouped)
        table.allowsMultipleSelection = false
        table.allowsMultipleSelectionDuringEditing = true
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.tableFooterView = UIView()
        table.backgroundColor = UIColor.clear
        table.backgroundView?.backgroundColor = UIColor.clear
        return table
    }()
    var viewModel : bbc_MeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
        self.view.layer.contents = UIImage(named: "532621")?.cgImage

    }

    override func setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        self.viewModel = bbc_MeViewModel(tableView)
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
