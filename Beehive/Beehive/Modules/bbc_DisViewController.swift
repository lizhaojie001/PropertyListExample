//
//  bbc_DisViewController.swift
//  Beehive
//
//  Created by macbook pro on 2019/3/31.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit
import SnapKit
class bbc_DisViewController: ViewController {

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view;
    }()
    lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = UIColor.clear
        return scrollview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        // Do any additional setup after loading the view.
    }
    
   private func setupView()  {
//    let backImage = UIImageView(image: UIImage(named: "178551554022126_.pic_hd"))
    view.layer.contents = UIImage(named: "178551554022126_.pic_hd")?.cgImage

    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { (make) in
        make.edges.equalToSuperview()
    }
    scrollView.addSubview(contentView)
    contentView.snp.makeConstraints { (maker ) in
        maker.edges.equalToSuperview()
        maker.width.equalToSuperview()
    }

    let timerView = XRCarouselView()
    timerView.contentMode = .scaleAspectFill
    let image1 = UIImage(named: "1024x0_1_q87_20131019092625876264")
    let image2 = UIImage(named: "1024x0_1_q87_20131026100326577264")
    let image3 = UIImage(named: "1024x0_1_q87_autohomecar__ChsEe1yQsAOATptNAASTs5qg0h4957")
    timerView.imageArray = [image1 as Any,image2 as Any,image3 as Any]
    contentView.addSubview(timerView)
    timerView.snp.makeConstraints { (maker) in
//        maker.width.equalTo(self.view)
        maker.height.equalTo(self.view.snp.width).multipliedBy(0.56)
        maker.top.leading.equalToSuperview().offset(5)
        maker.trailing.equalToSuperview().offset(-5)
    }

    let backView = UIView()
    backView.layer.cornerRadius = 5
    backView.backgroundColor = UIColor(white: 0, alpha: 0.7)
    contentView.addSubview(backView)
    backView.snp.makeConstraints { (maker) in
        maker.centerX.equalToSuperview()
        maker.width.equalToSuperview().multipliedBy(0.9)
        maker.top.equalTo(timerView.snp.bottom).offset(-20)
        maker.height.equalTo(80)
    }


//    let line = UIView()
//    line.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
//    contentView.addSubview(line)
//    line.snp.makeConstraints { (maker) in
//        maker.top.equalTo(timerView.snp.bottom).offset(5)
//        maker.height.equalTo(1)
//        maker.width.equalTo(self.view).multipliedBy(0.9)
//        maker.centerX.equalToSuperview()
//    }
//
//    let leftButton = UIButton(type: UIButton.ButtonType.custom)
//    leftButton.setImage(UIImage(named: "carMe"), for: UIControl.State.normal)
//    leftButton.backgroundColor = UIColor.white
//    contentView.addSubview(leftButton)
//    leftButton.snp.makeConstraints { (maker) in
//        maker.size.equalTo(CGSize(width: 125, height: 54))
//        maker.left.equalToSuperview().offset(16)
//        maker.top.equalTo(line.snp.bottom).offset(5)
//    }
//
//    let titleBtn = bbc_Button(text: "金融")
//    contentView.addSubview(titleBtn)
//    titleBtn.snp.makeConstraints { (maker) in
//        maker.left.equalTo(leftButton.snp.right)
//        maker.height.equalTo(leftButton.snp.height)
//        maker.width.equalTo(100)
//        maker.centerY.equalTo(leftButton)
//    }


    }

    override var preferredStatusBarStyle: UIStatusBarStyle
        {
        return .lightContent
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
