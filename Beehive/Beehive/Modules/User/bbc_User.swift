//
//  bbc_User.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/14.
//  Copyright © 2019 macbook pro. All rights reserved.
//

let User = bbc_User.shared
class bbc_User: bbc_BaseModel {
    static let shared = bbc_User()
    var customs_uname : String?
    var customs_pwd : String?
    var customs_email : String?
    var code : Int?

//登录成功后
    var customs_id : Int = -1
    var customs_head : String?
    var customs_address : String?

    required init() {}
}

extension bbc_User{
    func isLogin() -> Bool {
        return (self.customs_id != -1)
    }
}
