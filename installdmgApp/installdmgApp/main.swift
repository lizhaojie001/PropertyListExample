//
//  main.swift
//  installdmgApp
//
//  Created by xdf_yanqing on 2019/3/12.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Foundation

print("Hello, World!")

let process = Process.init()
process.environment = ["PATH":"/usr/bin;/bin/bash;/bin/;/usr/sbin"]

process.launchPath = "/bin/bash"
process.arguments = ["-c","cd /Users/xdf_yanqing/Downloads/"]

process.launch()

let process2 = Process.init()
process2.environment = ["PATH":"/usr/bin;/bin/bash;/bin/;/usr/sbin"]

process2.launchPath = "/usr/bin/open" ///usr/bin/open
//process2.arguments = ["-l","-c","cd /Users/xdf_yanqing/Downloads/;ls -l;/usr/bin/hdiutil mount 云直播.dmg; cp -R /Volumes/云直播/sac_mac.app /Applications;cd ~;/usr/bin/hdiutil  unmount '/Volumes/云直播'"]
//process2.arguments = ["-l","-c","cd /Users/xdf_yanqing/Downloads/;open  云直播.dmg"]
process2.arguments = ["/Users/xdf_yanqing/Downloads/云直播.dmg"]

let pipe = Pipe.init()
process2.standardError = pipe
let fileHander = pipe.fileHandleForReading
process2.launch()


let data = fileHander.readDataToEndOfFile()
print(String.init(data: data, encoding: String.Encoding.utf8))


//;cp -R 云直播.app Applications;cd ~;hdiutil detach  /Volumes/云直播/
///usr/bin/hdiutil  unmount '/Volumes/云直播'
