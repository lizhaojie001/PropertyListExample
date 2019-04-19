//
//  bbc_CollectionViewModel.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/14.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit
import Moya
import SwipeCellKit
class bbc_CollectionViewModel: NSObject {
    private let cellReuseIdentifier = "cellReuseIdentifier"
    private var tableViewData : [bbc_ShopcarModel] = [bbc_ShopcarModel]()
    private lazy var  provider: MoyaProvider  = { () -> MoyaProvider<CollectionAPI> in
        let provider  = MoyaProvider<CollectionAPI>()
        return provider
    }()
    private weak  var tableView : UITableView?
    convenience init(_ tableView : UITableView) {
        self.init()
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UINib.init(nibName: "bbc_CollectionCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

    }

   public func getshopcarList() {
    self.provider.request(CollectionAPI.shoplist(userid: 18)) { (result) in
        switch result{
        case let .failure(error):
            debugPrint(error)
        case let .success(moyaResponse):
            let data = moyaResponse.data
            if let jsonString  = String.init(data: data, encoding: String.Encoding.utf8){
                let  json = [bbc_ShopcarModel].deserialize(from: jsonString, designatedPath: "cart")
                debugPrint(jsonString)
                if (json != nil) {
                    self.tableViewData.removeAll()
                    self.tableViewData.append(contentsOf: (json as? [bbc_ShopcarModel])!)
                    self.tableView?.reloadData()
                }}
        }
    }
    }

}

extension bbc_CollectionViewModel : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.tableViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! bbc_CollectionCell
        cell.delegate = self
        let item = self.tableViewData[indexPath.row]
        cell.model = item
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! bbc_CollectionCell
        cell.choiceButton.isSelected = !cell.choiceButton.isSelected
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension bbc_CollectionViewModel : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if orientation == .right{
            let delete = SwipeAction(style: .destructive, title: NSLocalizedString("Delete.button.title", comment: "")) { (action, indexPath) in
                debugPrint(action,indexPath)
                
            }
            return [delete]
        }
        return []
    }


}
