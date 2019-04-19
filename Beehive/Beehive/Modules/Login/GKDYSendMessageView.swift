//
//  GKDYSendMessageView.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/16.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit

class GKDYSendMessageView: UIView {
    var timer : Timer?
    var message : String?
    weak var delegate : GKDYSendMessageViewDelegete?


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
 */
    override func draw(_ rect: CGRect) {
        // Drawing code
        let  paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle.default as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = NSTextAlignment.justified
        if self.isUserInteractionEnabled {
            (self.message! as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.paragraphStyle:paragraphStyle])
        }else{
            (self.message! as NSString).draw(in: rect, withAttributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.paragraphStyle:paragraphStyle])
        }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}


@objc protocol GKDYSendMessageViewDelegete {
    func sendMessageView(sendMsgView:GKDYSendMessageView, completeBlock : (_ value:String)->Void)
}
