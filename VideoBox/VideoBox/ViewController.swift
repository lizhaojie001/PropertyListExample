//
//  ViewController.swift
//  VideoBox
//
//  Created by xdf_yanqing on 2019/10/17.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit
import AudioToolbox
class ViewController: UIViewController {

    
    let feed =  UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor("#DCDCDC")
        // Do any additional setup after loading the view.
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (time) in
//            self.touch(nil)
        }
        timer.fire()
//        DispatchQueue.global().async {
//            self.test()
//        }
    }


    @IBAction func touch(_ sender: UIButton?) {
//        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
//        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
   
//        feed.prepare()
//        feed.impactOccurred()
        sender?.isSelected = !(sender?.isSelected ?? false)

        print(1)
    }
    
    
    func test() {
        var i  = 180.0
        let last = DispatchTime.now()
        while  i > 0{
            i -= 1
            let top = sin(i * Double.pi / 180)
            DispatchQueue.main.asyncAfter(deadline:last + top * 1.5 + 2) {
                self.touch(nil)
                sleep(1)
            }
        }
    }
}

