//
//  bbc_Shop.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/6.
//  Copyright © 2019 macbook pro. All rights reserved.
//

class bbc_Shop: bbc_BaseModel {
    var sp_id : Int?
    var sp_status : String?
    var sp_title : String?
    var sp_attr : String?
    var sp_price : String?
    var sp_num : String?
    var sp_pic : String?{
        didSet{
            sp_pic = BeehiveBaseURL.appendingPathComponent(sp_pic ?? "").absoluteString
        }
    }
    var sp_pic2 : String?{
        didSet{
            sp_pic2 = BeehiveBaseURL.appendingPathComponent(sp_pic2 ?? "").absoluteString
        }
    }
    var sp_address : String?
    var sp_content : String?
    required init() {}
}
