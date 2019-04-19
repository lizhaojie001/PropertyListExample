//
//  bbc_ItemsView.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/5.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_ItemsView: UIView {
    var items : [bbc_Item]?
    weak var delegate : bbc_ItemsViewProtocol?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    convenience init(items:[bbc_Item]) {
        assert(items.count != 0, "items 数组不能为空")
        self.init()
        self.items = items
        for i in 0...items.count - 1 {
            let item = items[i]
            let button = UIButton()
            button.tag = i + 1
            button.setImage(item.image, for: UIControl.State.normal)
            button.setTitle(item.text, for: UIControl.State.normal)
            button.addTarget(self, action: #selector(clickButton(button:)), for: UIControl.Event.touchUpInside)
            self.addSubview(button)
        }
    }

     @objc func clickButton(button:UIButton) {
        self.delegate?.didSelectItem(index: button.tag)
    }

    override func updateConstraints() {
        let multiplied = 1.0/CGFloat((self.items?.count)!)
        for item in subviews {
            if item is UIButton{
                if item.tag == 1 {
                    item.snp.makeConstraints { (maker) in
                        maker.left.height.equalToSuperview()
                        maker.width.equalToSuperview().multipliedBy(multiplied)
                        maker.centerY.equalToSuperview()
                    }
                }else if item.tag == self.items?.count{
                    item.snp.makeConstraints { (maker) in
                        maker.right.equalToSuperview()
                        maker.width.equalToSuperview().multipliedBy(multiplied)
                        maker.centerY.equalToSuperview()
                    }
                }else{
                    let tag = item.tag - 1
                    let button = self.viewWithTag(tag)
                    item.snp.makeConstraints({ (maker) in
                        maker.width.equalToSuperview().multipliedBy(multiplied)
                        maker.left.equalTo((button?.snp.right)!)
                        maker.centerY.equalToSuperview()
                    })
                }
            }
        }

        super.updateConstraints()
    }
}


@objc protocol bbc_ItemsViewProtocol : NSObjectProtocol{

   @objc func didSelectItem(index:Int)

}
