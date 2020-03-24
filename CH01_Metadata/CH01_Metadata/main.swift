//
//  main.swift
//  CH01_Metadata
//
//  Created by xdf_yanqing on 2020/3/18.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

import Foundation
import AudioToolbox
print("Hello, World!")

let url = URL(fileURLWithPath:"/Users/xdf_yanqing/Desktop/MacDemo/PropertyListExample/CH01_Metadata/CH01_Metadata/meta.mp3")
var audioId = AudioFileID(bitPattern: 1)
var theErr  = noErr
theErr = AudioFileOpenURL(url as CFURL, AudioFilePermissions.readWritePermission, 0, &audioId)
assert(theErr == noErr)
var pointer = UnsafeMutablePointer<uint32>.init(bitPattern: 1)
var dictionarySize : uint32 = 0
theErr = AudioFileGetPropertyInfo(audioId!, kAudioFilePropertyInfoDictionary, &dictionarySize,nil)
assert(theErr == noErr)
print(dictionarySize)
var dict : CFDictionary?
theErr = AudioFileGetProperty(audioId!, kAudioFilePropertyInfoDictionary, &dictionarySize, &dict)
print(dict,dictionarySize)

