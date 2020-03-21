//
//  HYModeTableViewCell.swift
//  VideoBox
//
//  Created by macbook pro on 2019/11/20.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit

class HYModeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    weak var switchView : UISegmentedControl?
    weak var progress : UIProgressView?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func updateConstraints() {
//        switchView?.snp.makeConstraints { (maker) in
//                 maker.edges.equalToSuperview()
//             }
        self.progress?.snp.makeConstraints({ (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalTo(2)
        })
        super.updateConstraints()
    }
    func setupView() {
            
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
