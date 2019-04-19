//
//  bbc_LoginViewController.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/16.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        do {
            self.loginButton.backgroundColor = try  UIColor(rgba_throws: "#400C12")
        } catch  {
        }

    }
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

}
