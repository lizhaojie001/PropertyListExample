//
//  bbc_LoginViewController.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/16.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_RigterViewController: UIViewController {

    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repasswordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var viewModel = bbc_LoginViewModel()
    @IBAction func handleDissmiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var handleDissmissButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNumberTF.attributedPlaceholder = NSAttributedString.init(string: NSLocalizedString("UserNamePlaceholder", comment: ""), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightText])
        self.passwordTF.attributedPlaceholder = NSAttributedString.init(string: NSLocalizedString("PhoneNumberPlaceholder", comment: ""), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightText])
        self.repasswordTF.attributedPlaceholder = NSAttributedString.init(string: NSLocalizedString("passwordPlaceholder", comment: ""), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightText])
        self.loginButton.setTitle(NSLocalizedString("Register.button.title", comment: ""), for: UIControl.State.normal)
        
        do {
            self.loginButton.backgroundColor = try  UIColor(rgba_throws: "#400C12")
        } catch  {
        }
        // Do any additional setup after loading the view.
    }


    @IBAction func handleLogin(_ sender: UIButton) {

        if self.phoneNumberTF.text?.count == 0 || self.passwordTF.text?.count == 0 || self.repasswordTF.text?.count == 0 {
            SVProgressHUD.showError(withStatus: NSLocalizedString("PhoneNil", comment: ""))
            return
        }

        SVProgressHUD.show(); self.viewModel.regier(["userName":self.phoneNumberTF.text!,"password":self.repasswordTF.text!,"phone":self.passwordTF.text!]) {[weak self] (success,message) in
            if success {
                SVProgressHUD.dismiss()
                self?.dismiss(animated: true, completion: nil)
            }else{
                SVProgressHUD.showError(withStatus: message)
            }
            debugPrint(success)
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
