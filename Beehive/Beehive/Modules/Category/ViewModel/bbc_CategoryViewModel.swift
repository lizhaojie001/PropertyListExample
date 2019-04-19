//
//  bbc_CategoryViewModel.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/7.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_CategoryViewModel: NSObject {
    private let itemReuseIndentifier = "itemReuseIndentifier"
    private let cellmReuseIndentifier = "cellmReuseIndentifier"
    lazy var datas: [Int : [Int : String]] = {
        let  dic = [0:[0 : "Tempoary Stop Sign",1 : "Steering Wheel Cover",2 : "Perfume",3:"Car Pillow",4:"Car Bracket"],1:[0:"Car Wax",1:"Detergent",2:"Car Wash Towel",3:"Glass Water",4:"Auto Paint Pen",5:"Antifogging Agent /Water Foolding"],2:[0:"Car Cleans",1:"Head-Up Display",2:"Car DVR",3:"Driver Assistance",4:"Car Charger",5:"Car Audio and Video",6:"Car Purifier"],3:[0:"Self-driving Camping",1:"Emergency Rescue",2:"Car Bed",3:"Storage Box",4:"Fire Extinguisher"]]
        return dic
    }()
    weak var tableView : UITableView?
    weak var colloctionView : UICollectionView?
    private var index : Int = -1
    convenience init(with tableView:UITableView,collection:UICollectionView) {
        self.init()
        tableView.delegate = self
        tableView.dataSource = self
        collection.delegate = self
        collection.dataSource = self
        collection.register(bbc_CategoryCollectionViewCell.self, forCellWithReuseIdentifier: itemReuseIndentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellmReuseIndentifier)
        self.tableView = tableView
        self.colloctionView = collection
        let indexPath = IndexPath.init(row: 0, section: 0)
        self.tableView?.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
        let cell = self.tableView?.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = UIColor.black
        self.index = 0 
    }
}

extension bbc_CategoryViewModel : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellmReuseIndentifier, for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.backgroundView?.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.detailTextLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor(white: 1, alpha: 0.9)
        cell.textLabel?.backgroundColor = UIColor.clear
        let text : String
        switch indexPath.row {
        case 0:
            text = "Car Decoration"
        case 1:
            text = "Automobile Beauty"
        case 2:
            text = "Automotive Electronics"
        default:
            text = "Safe Driving"

        }
        cell.textLabel!.text = text
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.colloctionView?.reloadData()
        if self.index != -1 || self.index != indexPath.row{
            let cell = self.tableView?.cellForRow(at: IndexPath(row: self.index, section: indexPath.section))
            cell?.textLabel?.textColor = UIColor(white: 1, alpha: 0.9)
        }
        let cell = self.tableView?.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = UIColor.black
        self.index = indexPath.row

    }

}

extension bbc_CategoryViewModel : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let number : Int
        switch  self.tableView?.indexPathForSelectedRow?.row{
        case 0:
            number = 5
        case 1:
            number = 6
        case 2:
            number = 7
        default:
            number = 5
        }
        return number
    }



    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item : bbc_CategoryCollectionViewCell = colloctionView?.dequeueReusableCell(withReuseIdentifier: itemReuseIndentifier, for: indexPath) as! bbc_CategoryCollectionViewCell
//        let item = bbc_CategoryCollectionViewCell.init()
        item.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        if let row = self.tableView?.indexPathForSelectedRow?.row{
            item.text = datas[row]?[indexPath.item] ?? ""
            debugPrint(item.text)
        }
        return item
    }

    //MARK:UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }


}
