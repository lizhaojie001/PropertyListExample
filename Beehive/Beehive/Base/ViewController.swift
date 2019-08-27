//
//  ViewController.swift
//  Beehive
//
//  Created by macbook pro on 2019/3/31.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.black//UIColor("#DIDCE2")

        setupView()
    }

   public func setupView() {

    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

