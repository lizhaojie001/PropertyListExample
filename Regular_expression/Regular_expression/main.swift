//
//  main.swift
//  Regular_expression
//
//  Created by xdf_yanqing on 2019/4/8.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Foundation

print("Hello, World!")
@discardableResult
func regular_expression(pattern : String, text : String) -> ([String],String) {
    var text1 = text
    do {
         let reg = try NSRegularExpression.init(pattern: pattern, options: [.caseInsensitive,.anchorsMatchLines])
            debugPrint(reg)
        let arr = reg.matches(in: text, options: [.reportProgress], range: NSRange.init(location: 0, length: text.count))
        var s  = ""
        var s3 : [String] = [String]()
        for item in arr {
            s =  s.appendingFormat("%@",(text as NSString).substring(with: item.range))
            if s.contains("}]")
            {
                s3.append(s )
               text1 =  text1.replacingOccurrences(of: s, with: "")
                s = ""
            }
            
        }
        return (s3,text1)
    } catch  {
        debugPrint(error)
    }
    
    return ([],"")
}

let pattern = "\\[Image:\\{\\w+\\.\\w+\\}\\]"
let text = "[Image:{rehoaiwghewaoi192047y1893471mlgjweoi2.png}]qwe1892[Image:{234567.234}]62986r329[Image:{rehoaiwghewaoi192047y.jpg}]"
regular_expression(pattern: pattern, text:text )


func regular_expression_predicate(patten:String,text:String) -> Void{
    let predicate = NSPredicate.init(format: "SELF MATCHES %@", text,patten)
    debugPrint()
}

//regular_expression_predicate(patten: pattern, text: text)
