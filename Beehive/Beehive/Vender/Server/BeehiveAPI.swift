//
//  BeehiveAPI.swift
//  Beehive
//
//  Created by macbook pro on 2019/4/6.
//  Copyright © 2019 macbook pro. All rights reserved.
//

import Moya
import Foundation

//MARK:首页

public enum DiscoverAPI {
    case newList
    case shoplist
}

extension DiscoverAPI: TargetType {
    public var path: String {
        switch self {
        case .newList:
            return "carlive/news_list.php"
        case .shoplist:
            return "carlive/splist.php"
        }
    }

    public var task: Task {
        switch self {
        case .newList,.shoplist:
            return .requestPlain
        }
    }

    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    public var baseURL: URL {
        return BeehiveBaseURL
    }

    public var method: Moya.Method{
        return .get
    }


    public var headers: [String : String]?{
        return [:]
    }
}

//MARK:购物车
public enum CollectionAPI {
    case shoplist(userid:Int)
    case deleteGoods(goodsId:String)
}

extension CollectionAPI: TargetType {
    public var path: String {
        switch self {
        case .shoplist(_):
            return "carlive/gwclisting.php"
        case .deleteGoods(_):
            return "carlive/gwc_sc.php"
        }
    }

    public var task: Task {
        var encoding : ParameterEncoding =  JSONEncoding.default
        switch self.method {
        case .post:
            fallthrough
        case .get:
            encoding = URLEncoding.default
        case .options:
            fallthrough
        case .head:
            fallthrough
        case .put:
            fallthrough
        case .patch:
            fallthrough
        case .delete:
            fallthrough
        case .trace:
            fallthrough
        case .connect: break
            }
        if let requestParmeters = parameters{
            return .requestParameters(parameters: requestParmeters, encoding: encoding)
        }
        return .requestPlain
    }

    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    public var baseURL: URL {
        return BeehiveBaseURL
    }

    public var method: Moya.Method{
        switch self {
        case  .shoplist(_),.deleteGoods(_):
            return .get
        }
    }


    public var headers: [String : String]?{
        return [:]
    }

    var parameters: [String: Any]? {
        var parameters :[String:Any] = [:]
        switch self {
        case .shoplist(let userid):
            parameters = parameters.merging(["useid": userid], uniquingKeysWith: { (current , _)  in current })
        case .deleteGoods(let goodsId):
            parameters = parameters.merging(["carts": goodsId], uniquingKeysWith: { (current , _)  in current })
        }
        return parameters
    }

}

//MARK:用户登录注册
public enum UserAPI {
    case regier(userName:String,password:String,usphone:String)
}

extension UserAPI: TargetType {
    public var path: String {
        switch self {
        case .regier(_,_,_):
            return "carlive/zhuce.php"
        }
    }

    public var task: Task {
        var encoding : ParameterEncoding =  JSONEncoding.default
        switch self.method {
        case .get:
            encoding = JSONEncoding.default
        case .options:
            fallthrough
        case .head:
            fallthrough
        case .post:
            fallthrough
        case .put:
            fallthrough
        case .patch:
            fallthrough
        case .delete:
            fallthrough
        case .trace:
            fallthrough
        case .connect: break
        }
        if let requestParmeters = parameters{
            return .requestParameters(parameters: requestParmeters, encoding: encoding)
        }
        return .requestPlain

    }

    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    public var baseURL: URL {
        return BeehiveBaseURL
    }

    public var method: Moya.Method{
        switch self {
        case  .regier(_,_,_):
            return .get
        }
    }


    public var headers: [String : String]?{
        return [:]
    }

    var parameters: [String: Any]? {
        var parameters :[String:Any] = [:]
        switch self {
        case let .regier(userName, password, usphone):
            parameters = parameters.merging(["uname": userName,"passwd":password,"usphone":usphone], uniquingKeysWith: { (current , _)  in current })

        }
        return parameters
    }

}
