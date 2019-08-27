import Cocoa
import AVFoundation

let asaset = AVAsset(url: URL(fileURLWithPath:"/Users/xdf_yanqing/Downloads/IMG_2479.MOV"))

let reader = try? AVAssetReader(asset: asaset)
let outputs = reader?.outputs
for put in outputs ?? [] {
    debugPrint(put)
}

