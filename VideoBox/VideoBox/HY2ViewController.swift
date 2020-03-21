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
        setupView()
    }
    
    private func setupView(){
        let switchView = UISegmentedControl(items: ["温柔","正常","急促"])
        if #available(iOS 13.0, *) {
            switchView.selectedSegmentTintColor = UIColor.white
        } else {
            // Fallback on earlier versions
        }
        let bgView = UIView()
        bgView.backgroundColor = UIColor.red
        self.tableView.addSubview(bgView)
        
        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        bgView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalTo(50)
            maker.top.equalTo(-50)
        }
        
        bgView.addSubview(switchView)
        switchView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        return HYModeTableViewCell()
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
