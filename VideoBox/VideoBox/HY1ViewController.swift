//
//  HY1ViewController.swift
//  VideoBox
//
//  Created by xdf_yanqing on 2019/10/17.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit
import SnapKit
class HY1ViewController: ViewController {

     @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "开始"
        setupView()
        // Do any additional setup after loading the view.
     
    }
    

    func setupView()  {
        
        if  UIDevice.platformString()?.contains("X") ?? false {
            self.bottomConstraint.constant = 100
        } else {
            self.bottomConstraint.constant = 70
        }
        
     
        let currentModel = UILabel(frame: CGRect.zero)
        currentModel.font = UIFont(name: "Helvetica Neue", size: 14)
        currentModel.text = "当前模式 : xxx"
        currentModel.textColor = UIColor("#8893AF")
        self.view.addSubview(currentModel)
        currentModel.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.top.equalTo(84)
        }
        let currentModel1 = HYLabel(frame: CGRect.zero)
        currentModel1.font = UIFont(name: "Helvetica Neue", size: 14)
        currentModel1.text = "当前频率 : xxxHZ"
        currentModel1.textColor = UIColor("#8893AF")
        self.view.addSubview(currentModel1)
        currentModel1.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.top.equalTo(currentModel.snp.bottom).offset(5)
        }
        
        let currentModel2 = HYLabel(frame: CGRect.zero)
        currentModel2.font = UIFont(name: "Helvetica Neue", size: 14)
        currentModel2.text = "当前电量 : xxxHZ"
        currentModel2.textColor = UIColor("#8893AF")

        self.view.addSubview(currentModel2)
        currentModel2.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.top.equalTo(currentModel1.snp.bottom).offset(5)
        }
        
        let currentModel3 = HYLabel(frame: CGRect.zero)
        currentModel3.font = UIFont(name: "Helvetica Neue", size: 14)
        currentModel3.text = "开启时长 : xxxHZ"
        currentModel3.textColor = UIColor("#8893AF")

        self.view.addSubview(currentModel3)
        currentModel3.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.top.equalTo(currentModel2.snp.bottom).offset(5)
        }
        let currentModel4 = HYLabel(frame: CGRect.zero)
        currentModel4.font = UIFont(name: "Helvetica Neue", size: 14)
        currentModel4.text = "开启状态 : xxxHZ"
        currentModel4.textColor = UIColor("#8893AF")

        self.view.addSubview(currentModel4)
        currentModel4.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.top.equalTo(currentModel3.snp.bottom).offset(5)
        }
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
