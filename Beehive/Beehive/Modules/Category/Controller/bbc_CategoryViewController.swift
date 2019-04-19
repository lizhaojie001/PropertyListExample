//
//  bbc_CategoryViewController.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/7.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_CategoryViewController: ViewController {

    var categoryViewModel: bbc_CategoryViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupView()  {
        self.navigationItem.title = "ClASSIFY"
        self.view.layer.contents = UIImage(named: "328224")?.cgImage
        let w : CGFloat = 80.0
        let leftTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: w, height: self.view.frame.height), style: UITableView.Style.plain)
        leftTableView.backgroundView?.backgroundColor = UIColor.clear
        leftTableView.backgroundColor = UIColor.clear
        leftTableView.separatorInset = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        leftTableView.tableFooterView = UIView()
        view.addSubview(leftTableView)

        let rightCollectionView = UICollectionView.init(frame: CGRect(x: w, y: 0, width: self.view.frame.width - w, height: self.view.frame.height), collectionViewLayout: UICollectionViewFlowLayout())
        rightCollectionView.backgroundView?.backgroundColor = UIColor.clear
        rightCollectionView.backgroundColor = UIColor.clear
        view.addSubview(rightCollectionView)
        categoryViewModel = bbc_CategoryViewModel(with: leftTableView, collection: rightCollectionView)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

}
