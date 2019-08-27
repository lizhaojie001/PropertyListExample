//
//  bbc_BaseNavigationController.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/7.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        do {
            try  self.navigationBar.barTintColor = UIColor(rgba_throws: "#400C12")
            self.navigationBar.isTranslucent = false
        } catch  {
            debugPrint(error)
        }
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
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
