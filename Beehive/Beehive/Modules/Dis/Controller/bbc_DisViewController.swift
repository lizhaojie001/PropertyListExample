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
        scrollview.bounces = false
        return scrollview
    }()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 7
        table.backgroundColor = UIColor.clear
        table.backgroundView?.backgroundColor = UIColor.clear
        table.tableFooterView = UIView()
        table.separatorColor = UIColor.clear
        return table
    }()
    lazy var discoverViewModel: bbc_DiscoverViewModel = {
        let viewModel = bbc_DiscoverViewModel(with: self.tableView)
        return viewModel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupView()  {
    let heightTimerView = self.view.frame.width * 0.56
    let offsetH : CGFloat = 50.0
    let heightBackView = offsetH + heightTimerView
    view.layer.contents = UIImage(named: "178551554022126_.pic_hd")?.cgImage
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (maker) in
        maker.edges.equalToSuperview()
    }

    let timerView = XRCarouselView()
    timerView.layer.shadowColor = UIColor.white.cgColor
    timerView.layer.shadowOffset = CGSize(width: 3, height: 3)
    timerView.contentMode = .scaleAspectFill
    let image1 = UIImage(named: "1024x0_1_q87_20131019092625876264")
    let image2 = UIImage(named: "1024x0_1_q87_20131026100326577264")
    let image3 = UIImage(named: "1024x0_1_q87_autohomecar__ChsEe1yQsAOATptNAASTs5qg0h4957")
    timerView.imageArray = [image1 as Any,image2 as Any,image3 as Any]
    tableView.addSubview(timerView)
    timerView.snp.makeConstraints { (maker) in
        maker.height.equalTo(heightTimerView)
        maker.width.equalToSuperview().offset(-10)
        maker.centerX.equalToSuperview()
        maker.bottom.equalTo(tableView.snp.top).offset(-offsetH)
    }

    let backView = UIView()
    backView.layer.cornerRadius = 9
    backView.backgroundColor = UIColor(white: 0, alpha: 0.7)

    let item1 = bbc_Item(text: "", image: UIImage(named: "home_car")!)
    let item2 = bbc_Item(text: "", image: UIImage(named: "evaluate")!)
    let item3 = bbc_Item(text: "", image: UIImage(named: "petrol station_home")!)
    let item4 = bbc_Item(text: "", image: UIImage(named: "red")!)
    let bbc_view  = bbc_ItemsView(items: [item1,item2,item3,item4])
    backView.addSubview(bbc_view)
    bbc_view.snp.makeConstraints { (maker) in
        maker.edges.equalToSuperview()
    }
    tableView.addSubview(backView)
    backView.snp.makeConstraints { (maker) in
        maker.centerX.equalToSuperview()
        maker.width.equalToSuperview().multipliedBy(0.9)
        maker.top.equalTo(timerView.snp.bottom).offset(-30)
        maker.height.equalTo(80)
    }

    tableView.contentInset.top = heightBackView

    self.discoverViewModel.loadData()
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

