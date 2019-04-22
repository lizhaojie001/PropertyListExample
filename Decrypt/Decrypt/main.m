//
//  main.m
//  Decrypt
//
//  Created by xdf_yanqing on 2019/3/29.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "TsDecrypt.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
//         long encryptKey = 612400680;
        TsDecrypt * ts =  [TsDecrypt new];
//        NSLog(@"%s",[ts getDecryptByte:encryptKey]);
//        [ts decryptData:encryptKey];
        // Insert code here to initialize your application
//        debugPrint(CACurrentMediaTime());
//        NSLog(@"%f",CACurrentMediaTime());
//        sleep(5);
//        NSLog(@"%f",CACurrentMediaTime());
        NSString * path = @"/Users/xdf_yanqing/Downloads/images/ddz_game/bg.jpg";
        NSString * path2 = @"/Users/xdf_yanqing/Downloads/images/ddz_game/btn_atuo.png";
        NSData * data = [[NSData alloc]initWithContentsOfFile:path];
        NSData * data2 = [[NSData alloc]initWithContentsOfFile:path2];
        NSLog(@"%s",[data bytes]);
        NSLog(@"%s",[data2 bytes]);

//        [ts decryptBase64:@"102A1D18EE79" withImage:path];
        
        

    }
    return 0;
}
