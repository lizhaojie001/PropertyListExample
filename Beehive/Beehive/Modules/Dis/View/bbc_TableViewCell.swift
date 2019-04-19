//
//  bbc_TableViewCell.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/5.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit
import Kingfisher
class bbc_TableViewCell: UITableViewCell {

    var item : bbc_Shop?{
        didSet{
            if (item?.sp_pic) != nil{
//                imageView?.kf.setImage(with:BeehiveBaseURL.appendingPathComponent(pic))
            }
            if let title = item?.sp_title{
                textLabel?.text = title
//                detailTextLabel?.text = title
            }
            if let detail = item?.sp_attr{
                detailTextLabel?.text = detail
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        backgroundView?.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        detailTextLabel?.backgroundColor = UIColor.clear
        textLabel?.textColor = UIColor(white: 1, alpha: 0.9)
        imageView?.contentMode = .scaleAspectFill
        textLabel?.font = UIFont.systemFont(ofSize: 14)
        textLabel?.numberOfLines = 3
        detailTextLabel?.font = UIFont.systemFont(ofSize: 11)
        detailTextLabel?.numberOfLines = 2
        detailTextLabel?.textColor = UIColor.lightText
    }

    override func updateConstraints() {
        imageView?.snp.makeConstraints({ (maker) in
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().offset(5)
            maker.height.equalToSuperview().offset(5)
            maker.width.equalTo(self.snp.height).multipliedBy(1.8)
        })
        textLabel?.snp.makeConstraints({ (maker) in
            maker.top.equalTo((imageView?.snp.top)!)
            maker.left.equalTo((imageView?.snp.right)!).offset(5)
            maker.right.equalToSuperview().offset(-5)
        })
        super.updateConstraints()
    }
}
