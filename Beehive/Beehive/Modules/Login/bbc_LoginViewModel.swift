//
//  bbc_LoginViewModel.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/20.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import UIKit
import Moya
class bbc_LoginViewModel: NSObject {
    private lazy var  provider: MoyaProvider  = { () -> MoyaProvider<UserAPI> in
        let provider  = MoyaProvider<UserAPI>()
        return provider
    }()
    func regier(_ params : [String : Any],completeBlock:@escaping (_ success : Bool,_ message:String)->Void){
        let userName  = params["userName"]
        let password = params["password"]
        let phone = params["phone"]
        self.provider.request(UserAPI.regier(userName: userName as! String, password: password as! String, usphone: phone as! String)) { (result) in
            switch result{
            case let .failure(error):
                debugPrint(error)
                completeBlock(false, error.localizedDescription)
            case let .success(moyaResponse):
                let data = moyaResponse.data
                if let jsonString  = String.init(data: data, encoding: String.Encoding.utf8){
                    let  json = bbc_User.deserialize(from: jsonString)
                    debugPrint(jsonString)
                    if json != nil,json?.code == 1  {
                        bbc_User.shared.customs_uname = userName as? String
                        bbc_User.shared.customs_pwd = password as? String
                        completeBlock(true,"")
                        return
                    }else if json?.code == 3{
                        completeBlock(false,NSLocalizedString("Account.tip.text", comment: ""))
                    }

                }
                completeBlock(false,"")
            }


        }
    }

    func login(_ params : [String : String] , completeBlock:@escaping (_ success : Bool,_ message : String)->Void) {
        let username = params["userName"]!
        let password = params["password"]
        self.provider.request(UserAPI.login(userName: username, password: password!)) { (result) in
            switch result{
            case let .failure(error):
                debugPrint(error)
                completeBlock(false,error.localizedDescription)
            case let .success(moyaResponse):
                let data = moyaResponse.data
                if let jsonString  = String.init(data: data, encoding: String.Encoding.utf8){
                    let  json = bbc_User.deserialize(from: jsonString, designatedPath: "user")
                    debugPrint(jsonString)
                    if json != nil{
                        bbc_User.shared.customs_uname = username
                        bbc_User.shared.customs_pwd = password
                        bbc_User.shared.customs_email = json?.customs_email
                        bbc_User.shared.customs_id = json?.customs_id ?? -1
                        bbc_User.shared.customs_address = json?.customs_address
                        completeBlock(true,"")
                        return
                    }
                }
                completeBlock(false,NSLocalizedString("Login.error", comment: ""))
            }
        }
    }
}
