//
//  bbc_CategoryCollectionViewCell.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/7.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class bbc_CategoryCollectionViewCell: UICollectionViewCell {

    lazy var label: UILabel = {
        let l = UILabel(frame: self.frame)
        l.textColor = UIColor(white: 1.0, alpha: 0.7)
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    var text : String {
        didSet{
            if !text.isEmpty {
                self.label.text = text
            }
        }
    }

    override init(frame: CGRect) {
        self.text = ""
        super.init(frame: frame)
        if self.label.superview == nil {
            addSubview(self.label)
        }
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundView?.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.label.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.height.equalToSuperview()
        }
        super.layoutSubviews()
    }
}
