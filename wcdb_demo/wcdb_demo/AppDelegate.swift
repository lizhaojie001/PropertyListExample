//
//  AppDelegate.swift
//  wcdb_demo
//
//  Created by xdf_yanqing on 2019/5/7.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import WCDBSwift

class Sample: TableCodable {
    var identifier: Int? = nil
    var description: String? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case description
    }
}

class Metial_Class: TableCodable {
    var id: Int? = nil
    var name_en:String? = nil
    var name_cn:String? = nil
    var md5:String? = nil //若是zip文件, 则是 ppt或者pdf的md5值
    var fileType:MatialFileType?
    var subFileType:MatialFileType.LectureType?
    var url:String? = nil
    var zipURL:String? = nil//含有教案的课程
    private var _path : String?
    var path: String? {
        get{
            return _path
        }
        set{
            _path = newValue
        }
    }
    var date : Date?

  

    enum CodingKeys: String, CodingTableKey {
        typealias Root = Metial_Class
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case id
        case name_en
        case name_cn
        case md5
        case fileType
        case subFileType
        case url
        case zipURL
        case _path
        case date
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                id : ColumnConstraintBinding(isPrimary: true),
//                description: ColumnConstraintBinding(isNotNull: true, defaultTo: "defaultDescription"),
            ]
        }
        
        
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    lazy var database: Database = {
        let database = Database(withPath: "/Users/xdf_yanqing/Desktop/DB/MetialList3.db")
        return database
    }()
    var index = 0
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    @IBAction func createDB(_ sender: Any) {
//        let database = Database(withPath: "/Users/xdf_yanqing/Desktop/DB/MetialList3.db")
//        debugPrint(database)
//        self.database = database
    }
    
    @IBAction func createTables(_ sender: Any) {
        do {
            try self.database.create(table: "MetialList", of: Metial_Class.self)
            try self.database.create(table: "Sample", of: Sample.self)
        } catch  {
            debugPrint(error)
        }
    }
    
    @IBAction func add(_ sender: NSButton) {
        let matial = Metial_Class()
        matial.id = index + 1
        matial.name_cn = "123"
        matial.name_en = "456"
        matial.md5 = "serdtfyguio2jp4k354jh3iu2598"
        matial.fileType = .lecture
        matial.subFileType = .PDF
        matial.url = "www.xdf.cn"
        matial.zipURL = "www.xdf.cn"
        matial.path  = "/Users/anc/dfahidf/fewaiuhf/oo"
        matial.date = Date()
        let object = Sample()
        object.identifier = index
        object.description = "sample_insert"
        
        
  
        do {
            try   self.database.insertOrReplace(objects: [matial], intoTable: "MetialList")
            let transaction = try database.getTransaction()
            try transaction.run(transaction: {
               try transaction.insert(objects: object, intoTable: "Sample")
                })
        } catch  {
            debugPrint(error)
        }
        index += 1
        
    }
    @IBAction func delete(_ sender: Any) {
        
        do {
//            try self.database.delete(fromTable: "MetialList", where: Metial_Class.Properties.id == 4)
            try self.database.delete(fromTable: "MetialList")
        } catch  {
            debugPrint(error)
        }
        
    }
    
    @IBAction func update(_ sender: Any) {
        let matial = Metial_Class()
        matial.id = 3
        matial.md5 = "I Hate U"
        do {
            try self.database.update(table: "MetialList", on: [Metial_Class.Properties.md5], with: matial ,where: Metial_Class.Properties.id == 3)

        } catch  {
            debugPrint(error)
        }
    }
    @IBAction func query(_ sender: Any) {
        do {
            let objects: [Metial_Class] = try database.getObjects(fromTable: "MetialList",
                                                            where: Metial_Class.Properties.id < 5 || Metial_Class.Properties.id > 10)
            let objes : [Metial_Class] = try self.database.getObjects(on: Metial_Class.Properties.id, fromTable: "MetialList")
            debugPrint(objects)
            debugPrint(objes)
        }catch{debugPrint(error)}

    }
}

enum MatialFileType : Int64 , ColumnCodable {
    init?(with value: FundamentalValue) {
        self = MatialFileType(rawValue: value.int64Value) ?? .none
    }
    
    func archivedValue() -> FundamentalValue {
        return FundamentalValue(self.rawValue)
    }
    
    static var columnType: ColumnType {
        get{
            return ColumnType.integer64
        }
        
    }
    
    case folder = 0
    case lecture = 1 //课件子类型 ppt pdf
    case audio = 2
    case video = 3
    case none = -1
    
    enum LectureType : Int64 ,ColumnCodable{
        init?(with value: FundamentalValue) {
            self = MatialFileType.LectureType(rawValue: value.int64Value) ?? .None
        }
        
        func archivedValue() -> FundamentalValue {
            return FundamentalValue(self.rawValue)
        }
        
        static var columnType: ColumnType {
            get{
                return ColumnType.integer64
            }
        }
        
        case None = 0
        case PDF = 1
        case PPT = 2
    }
}

