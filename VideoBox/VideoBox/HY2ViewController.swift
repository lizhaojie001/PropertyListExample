//
//  HY2ViewController.swift
//  VideoBox
//
//  Created by xdf_yanqing on 2019/10/17.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit

class HY2ViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "模式"
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
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

extension HY2ViewController : UITabBarDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "触觉强度"
        case 1:
            return "触觉速度"
        default:
            return "震动速度"
            
        }
    }
    
}
