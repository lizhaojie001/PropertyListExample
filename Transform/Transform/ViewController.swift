//
//  ViewController.swift
//  Transform
//
//  Created by xdf_yanqing on 2019/11/20.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var icon2: UIImageView!
    private weak var icon : UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let icon = UIImageView(frame: CGRect(x: 200, y: 200, width: 46, height: 46))
        icon.image = UIImage.init(named: "states_public_loading")
        self.view.addSubview(icon)
        self.icon = icon
    }


    @IBAction func rotation(_ sender: Any) {
        guard let transform =  (self.icon2?.layer.transform) else { return }
        let transformRotation = CATransform3DRotate(transform, CGFloat.pi/2, 0, 0, 1)
        self.icon2?.layer.transform = transformRotation
        
    }
}

