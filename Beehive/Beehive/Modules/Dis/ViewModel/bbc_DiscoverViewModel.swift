//
//  bbc_DiscoverViewModel.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/6.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
class bbc_DiscoverViewModel: NSObject {
    private let  discoverCellIdentifier = "discoverCell"
    private weak var tableView : UITableView?
    private var tableViewData : [bbc_Shop]?
    private lazy var  provider: MoyaProvider  = { () -> MoyaProvider<DiscoverAPI> in
        let provider  = MoyaProvider<DiscoverAPI>()
        return provider;
    }()
    convenience init(with tableView:UITableView) {
        self.init()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView = tableView
        tableView.register(bbc_TableViewCell.self, forCellReuseIdentifier: discoverCellIdentifier)
    }

   public func loadData() {
        self.provider.request(DiscoverAPI.shoplist) {[weak self] (result) in
            switch result{
            case let .failure(error):
                debugPrint(error)
                break
            case let .success(moyaResponse):
                let data = moyaResponse.data
                if let jsonString  = String.init(data: data, encoding: String.Encoding.utf8){
                    let  json = [bbc_Shop].deserialize(from: jsonString, designatedPath: "list")
                    self?.tableViewData = json as? [bbc_Shop]
                    self?.tableView?.reloadData()
                }
            }
        }
    }

   public func reloadTableView() {

    }
}

extension bbc_DiscoverViewModel : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.tableViewData![indexPath.row]
        let bbcCell : bbc_TableViewCell = tableView.dequeueReusableCell(withIdentifier: discoverCellIdentifier, for: indexPath) as! bbc_TableViewCell
        bbcCell.item = item
        return bbcCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
