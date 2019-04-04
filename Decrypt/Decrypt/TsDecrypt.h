//
//  TsDecrypt.h
//  Decrypt
//
//  Created by xdf_yanqing on 2019/3/29.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TsDecrypt : NSObject <NSStreamDelegate>
-(Byte*)getDecryptByte:(long)encryptKey;
-(void)decryptData:(long) encryptKey;


-(void)decryptBase64:(NSString*)key withImage:(NSString*)path;
@end

NS_ASSUME_NONNULL_END
