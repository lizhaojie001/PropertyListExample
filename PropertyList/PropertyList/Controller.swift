//
//  Controller.swift
//  PropertyListExample
//
//  Created by xdf_yanqing on 2019/3/12.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa

class Controller: NSObject {

    private var personName : String?
    private var phoneNumbers : Array<Any>?
    
    override init() {
        super.init()
        var errorDesc : String? = nil
        var format : PropertyListSerialization.PropertyListFormat? = .xml
        var plistPath :String? = nil
        let rootPath:String? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        plistPath = rootPath! + "/Data.plist"
        print(plistPath)
        if !FileManager.default.fileExists(atPath: plistPath!) {
            plistPath =  Bundle.main.path(forResource: "Data", ofType: "plist")
        }
      
     
        let plistXML : Data? = FileManager.default.contents(atPath: plistPath!)
        do {
            let temp  = try PropertyListSerialization.propertyList(from: plistXML!, options: .mutableContainersAndLeaves, format: &format!)
            
            let object = temp as? Dictionary<String, Any>
            if !(object?.isEmpty)! {
                personName = object!["name"] as? String
                phoneNumbers = object!["Phones"] as? Array<Any>
            }
         
        } catch  {
            
         print(error)
        }

    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
//        var error = ""
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true ).first
        let plistPath = rootPath! + "/Data.plist"
        print(plistPath)
        let plistDict: [String : Any] = ["name":personName as Any,"Phones":phoneNumbers as Any]
        do {
            let plistData : Data = try PropertyListSerialization.data(fromPropertyList: plistDict, format: PropertyListSerialization.PropertyListFormat.xml, options: .bitWidth)
            if !plistData.isEmpty{
                try plistData.write(to: URL.init(fileURLWithPath: plistPath))
            }
        } catch  {
            print(error)
        }
     
        return .terminateNow
        
        
        
    }
}


extension Controller : NSTableViewDataSource{
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (self.phoneNumbers?.count)!
    }
 
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return phoneNumbers![row]
    }
    
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
//        phoneNumbers?.remove(at: row)
//        phoneNumbers?.insert(object as Any, at: row)
    }
}
