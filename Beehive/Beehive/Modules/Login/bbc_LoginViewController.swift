//
//  bbc_LoginViewController.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/20.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_LoginViewController: ViewController {

    @IBOutlet weak var phoneOruserName: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = bbc_LoginViewModel()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneOruserName.attributedPlaceholder = NSAttributedString.init(string: NSLocalizedString("UserNamePlaceholder", comment: ""), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        self.passwordTF.attributedPlaceholder = NSAttributedString.init(string: NSLocalizedString("passwordPlaceholder", comment: ""), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightText])
        self.loginButton.setTitle(NSLocalizedString("Login.button.title", comment: ""), for: UIControl.State.normal)
        self.regiterButton.setTitleColor(UIColor.white, for: .normal)
        self.regiterButton.setTitle(NSLocalizedString("Account.create.title", comment: ""), for: UIControl.State.normal)
        // Do any additional setup after loading the view.
        do{
            self.loginButton.backgroundColor = try  UIColor(rgba_throws: "#400C12")

        }catch{}

    }


    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBOutlet weak var regiterButton: UIButton!

    @IBAction func reigter(_ sender: UIButton) {
        let reigter = bbc_RigterViewController.init(nibName: "bbc_RigterViewController" , bundle: nil)
        self.present(reigter, animated: true, completion: nil)
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func login(_ sender: Any) {
        SVProgressHUD.show()
        if self.passwordTF.text?.count == 0 || self.phoneOruserName.text?.count == 0{
            SVProgressHUD.showError(withStatus: NSLocalizedString("PhoneNil", comment: ""))
            return
        }

        self.viewModel.login(["userName":self.phoneOruserName.text!,"password":self.passwordTF.text!]) { (success,message) in
            if success {
                SVProgressHUD.dismiss()
                let appdelete = UIApplication.shared.delegate
                if let window = appdelete?.window{
                    let  storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateInitialViewController()
                    window?.rootViewController = controller
                    window?.makeKeyAndVisible()
                    (appdelete as! AppDelegate).setupYALTabBarController()
                }

            }else{
                SVProgressHUD.showError(withStatus: message)
            }
        }
    }

}
