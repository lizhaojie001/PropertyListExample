//
//  ViewController.swift
//  VideoBox
//
//  Created by xdf_yanqing on 2019/10/17.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import UIKit
import AudioToolbox
class ViewController: UIViewController {

    
    let feed =  UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.heavy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor("#DCDCDC")
        // Do any additional setup after loading the view.
//        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (time) in
////            self.touch(nil)
//        }
//        timer.fire()

        
        var request = URLRequest(url: URL(string: "https://www.clipconverter.cc/check.php")!)
        request.setValue("www.clipconverter.cc", forHTTPHeaderField: "Host")
//        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:69.0) Gecko/20100101 Firefox/69.0", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json, text/javascript, */*", forHTTPHeaderField: "Aqccept")
//        request.setValue("zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2", forHTTPHeaderField: "Accept-Language")
//        request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
//        request.setValue("520", forHTTPHeaderField: "Content-Length")
        request.setValue("https://www.clipconverter.cc/", forHTTPHeaderField: "Referer")
        var dict = [String: Any]()
        dict["mediaurl"] = "https://youtu.be/T6FBfNpiBYw"
        dict["filename"] = ""
        dict["filetype"] = ""
        dict["format"] = ""
        dict["audiovol"] = "0"
        dict["audiochannel"] = "2"
        dict["audiobr"] = "128"
        dict["videobr"] = "224"
        dict["videores"] = "352x288"
        dict["videoaspect"] = ""
        dict["customres"] = "320x240"
        dict["timefrom-start"] = "1"
        dict["timeto-end"] = "1"
        dict["id3-artist"] = ""
        dict["id3-title"] = ""
        dict["id3-album"] = "ClipConverter.cc"
        dict["auto"] = "0"
        dict["hash"] = ""
        dict["image"] = ""
        dict["org-filename"] = ""
        dict["videoid"] = ""
        dict["pattern"] = ""
        dict["server"] = ""
        dict["serverinterface"] = ""
        dict["service"] = ""
        dict["ref"] = ""
        dict["lang"] = "en"
        dict["client_urlmap"] = "none"
        dict["ipv6"] = "false"
        dict["addon_urlmap"] = ""
        dict["cookie"] = ""
        dict["addon_cookie"] = ""
        dict["addon_title"] = ""
        dict["ablock"] = "1"
        dict["clientside"] = "0"
        dict["addon_page"] = "none"
        dict["verify"] = ""
        dict["result"] = ""
        dict["again"] = ""
        dict["addon_browser"] = ""
        dict["addon_version"] = ""
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return }
        request.httpBody = data
        request.httpMethod = "POST"
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let task =   URLSession.shared.dataTask(with: request) { (ddt, response, error) in
            debugPrint(response,error)
            guard let d = ddt else { return }
            debugPrint(String(data: d, encoding: String.Encoding.utf8))
        }
        
        task.resume()
        

    }


    @IBAction func touch(_ sender: UIButton?) {
//        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
//        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
   
//        feed.prepare()
//        feed.impactOccurred()
        sender?.isSelected = !(sender?.isSelected ?? false)

        print(1)
    }
    
    
    func test() {
        var i  = 180.0
        let last = DispatchTime.now()
        while  i > 0{
            i -= 1
            let top = sin(i * Double.pi / 180)
            DispatchQueue.main.asyncAfter(deadline:last + top * 1.5 + 2) {
                self.touch(nil)
                sleep(1)
            }
        }
    }
}

