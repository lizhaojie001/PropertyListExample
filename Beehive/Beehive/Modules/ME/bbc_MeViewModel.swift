//
//  bbc_MeViewModel.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/20.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_MeViewModel: NSObject {
    private weak  var tableView : UITableView?
    convenience init(_ tableView : UITableView) {
        self.init()
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UINib.init(nibName: "bbc_MeImageCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

extension bbc_MeViewModel : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
