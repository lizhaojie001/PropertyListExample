//
//  AppDelegate.swift
//  FMDB_Demo
//
//  Created by xdf_yanqing on 2019/5/18.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import LKDBHelper
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    @IBAction func add(_ sender: Any) {
        var item = [String :Any]()
        item["id"] = 123
        item["name"] = "李赵杰"
        item["zip_url"] = "https://codeload.github.com/li6185377/LKDBHelper-SQLite-ORM/zip/master"
        item["url"] = "https://codeload.github.com/li6185377/LKDBHelper-SQLite-ORM/zip/master"
        item["md5"] = "bf7163f4d099f21a7e017c0797907b90"
        item["thumb_url"] = "1233333333"
        let preloadMaterial = PreLoadMaterial(item: item)
//        PreLoadMaterial.getUsingLKDBHelper().insert(toDB: preloadMaterial)
        let info = PreLoadMaterial.getModelInfos()
        debugPrint(info.count , info.printAllPropertys(),preloadMaterial.db_tableName,PreLoadMaterial.getUsingLKDBHelper().printAllPropertys())
        
    }
    
    
    @IBAction func delete(_ sender: Any) {
    }
    
    @IBAction func update(_ sender: Any) {
    }
    @IBAction func query(_ sender: Any) {
    }
}



enum MatialStatus : Int{

    case isError = -1
    case isUnLoad = 0
    case isLocaled = 1
    case isLoading = 2
}

class PreLoadMaterial: NSObject {
    var id : UInt64?
//    var sub_type : MatialFileType.LectureType?
//    var type : MatialFileType?
    var name: String?
    var zip_url : String?
    var md5 : String?
    var url : String?
    var size : UInt64?
    var thumb_url : String?
    //自定义属性
    var createDate : Date?
    var filePath : String?
    var status : MatialStatus? = .isUnLoad
    var cid : UInt64?
    
    var downloadURL : String {
        if hasNotes {
            return self.zip_url ?? ""
        }else{
            return self.url ?? ""
        }
    }
    var hasNotes: Bool {
        return self.zip_url?.isEmpty ?? false ? false : true
    }
    
    var localName: String {
        
        if hasNotes {
            
            if let zipURL = self.zip_url as NSString? {
                (((zipURL.lastPathComponent as NSString).deletingPathExtension) as NSString).appendingPathExtension("pdf")
             }        }
        return (self.url! as NSString).lastPathComponent
    }
    
    var isLocalExist : Bool {
        let item = PreLoadMaterial.getUsingLKDBHelper().searchSingle(PreLoadMaterial.self, where: String(format: "id = %lu", self.id ?? 0), orderBy: nil)
        return item != nil
    }
    
    
    convenience init(item : [String : Any]) {
        self.init()
        let courseid = item["id"] as? UInt64
        let name = item["name"] as? String
        let md5 = item["md5"] as? String
//        let type = item["type"] as? Int64 ?? -1
//        let fileType = MatialFileType(rawValue: type )
//        let subType = item["sub_type"] as? Int64 ?? 0
//        let subFileType = MatialFileType.LectureType(rawValue: subType )
        let url = item["url"] as? String
        let zipURL = item["zip_url"] as? String
        //        let update_time = item["update_time"] as? UInt64
        let size = item["size"] as? UInt64
        let thumb_url = item["thumb_url"] as? String
        let cid = item["cid"] as? UInt64
        self.id = courseid
        self.name = name
        self.md5 = md5
//        self.type = fileType
//        self.sub_type = subFileType
        self.url = url
        self.zip_url = zipURL
        self.size = size
        self.thumb_url = thumb_url
        self.cid = cid
        
    }
    
    override static func getPrimaryKey() -> String {
        return "id"
    }
    
    override static func getTableName() -> String {
        return "PredownloadMaterialTable"
    }
    
}



class CourseInformation: NSObject {
    var tea_nickname : String?
    var tea_username : String?
    var cid : String?
    var tea_id : UInt64?
    var end_time : UInt64?
    var start_time : UInt64?
    var name : String?
    var pre_enter_time : UInt64?
    
    convenience init(data: [String:Any]) {
        self.init()
        let cid = data["cid"] as? String
        let name = data["name"] as? String
        let start_time = data["start_time"] as? UInt64
        let end_time = data["end_time"] as? UInt64
        let pre_enter_time = data["pre_enter_time"] as? UInt64
        let tea_id = data["tea_id"] as? UInt64
        let tea_nickname = data["tea_nickname"] as? String
        let tea_username = data["tea_username"] as? String
        
        self.cid = cid
        self.name = name
        self.start_time = start_time
        self.end_time = end_time
        self.pre_enter_time = pre_enter_time
        self.tea_id = tea_id
        self.tea_nickname = tea_nickname
        self.tea_username = tea_username
    }
    
    override static func getPrimaryKey() -> String {
        return "cid"
    }
    
    override static func getTableName() -> String {
        return "CourseInformationTable"
    }

    
}
