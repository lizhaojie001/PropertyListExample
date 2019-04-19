//
//  bbc_CollectionCell.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/14.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit
import SwipeCellKit
class bbc_CollectionCell: SwipeTableViewCell {

    @IBOutlet weak var choiceButton: UIButton!
    var model: bbc_ShopcarModel {
        didSet{
            if let pic = model.sp_pic {
                let l = BeehiveBaseURL.appendingPathComponent(pic).absoluteString
                icon.kf.setImage(with: URL.init(string: l))
            }
            if let title = model.sp_title{
                titleLabel.text = title
            }
            if let price = model.sp_price{
                priceLabel.text = price
            }
            if let number = model.gwc_num
            {
                numberTF.text = String(number)
            }
        }
    }

    @IBOutlet weak var icon: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var numberTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundView?.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.model = bbc_ShopcarModel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    required init?(coder aDecoder: NSCoder) {
        self.model = bbc_ShopcarModel()
        super.init(coder: aDecoder)
    }

    @IBAction func deteleNumber(_ sender: UIButton) {
        if self.model.gwc_num! > 0{
            let M = self.model
            M.gwc_num = M.gwc_num! - 1
            self.model = M
        }
    }

    @IBAction func addNumber(_ sender: UIButton) {
        let M = self.model
        M.gwc_num = M.gwc_num! + 1
        self.model = M
    }

    @IBAction func choiceToBuy(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

}
