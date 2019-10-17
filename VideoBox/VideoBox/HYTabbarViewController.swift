
//
//  HYTabbarViewController.swift
//  VideoBox
//
//  Created by xdf_yanqing on 2019/10/17.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit
import AudioToolbox

class HYTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        HYToolinstance.shake()
    }
}
