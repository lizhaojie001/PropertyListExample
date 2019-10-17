//
//  HYNavigationViewController.swift
//  VideoBox
//
//  Created by xdf_yanqing on 2019/10/17.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit

class HYNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor("#E0E2E0")
        // Do any additional setup after loading the view.
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.gray
        shadow.shadowOffset = CGSize(width: 0.5, height: 0.5)
        shadow.shadowBlurRadius = 0.5
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor("#8893AF"),NSAttributedString.Key.shadow : shadow,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
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
