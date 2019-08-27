//
//  bbc_BaseViewController.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/20.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_BaseViewController: YALFoldingTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
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

extension bbc_BaseViewController : UITabBarControllerDelegate{

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        debugPrint(bbc_User.shared.customs_id as Any)
        if !bbc_User.shared.isLogin() {
              let login = bbc_LoginViewController.init(nibName: "bbc_LoginViewController", bundle: nil)
            if let navigationController : bbc_BaseNavigationController = viewController as? bbc_BaseNavigationController {
                if navigationController.topViewController is bbc_CollectioinViewController
                {
                    self.present(login, animated: true, completion: nil)
                    return false
                }
            }else if viewController is bbc_MeViewController{
                self.present(login, animated: true, completion: nil)
                return false
            }

            return true
        }
        return true
    }
}
