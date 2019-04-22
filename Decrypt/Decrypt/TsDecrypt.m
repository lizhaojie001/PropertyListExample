//
//  TsDecrypt.m
//  Decrypt
//
//  Created by xdf_yanqing on 2019/3/29.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

#define ACTION_PREPARE_FROM_SEARCH 65536
#define CYPHER_FILE "D:\\test\\Cypher_File_Java.ts"
#define DECRYPTED_FILE "D:\\test\\Decrypted_File_Java.ts"
#import "TsDecrypt.h"

@implementation TsDecrypt

- (Byte *)getDecryptByte:(long)encryptKey{
        Byte *byte= (Byte*)malloc(4);
     int a = (int)((encryptKey / 16777216) % 256);
     int b = (int)((encryptKey / ACTION_PREPARE_FROM_SEARCH) % 256);
     int c = (int)((encryptKey / 256) % 256);
     int d = (int)(encryptKey % 256);
    byte[0] = (Byte)a;
    byte[1] = (Byte)b;
    byte[2] = (Byte)c;
    byte[3] = (Byte)d;
    return byte;
}

- (Byte *)intToByte:(int)value
{
    Byte *byte= (Byte*)malloc(4);
    
    byte[0] =(Byte) ((value>>24) & 0xFF);
    
    byte[1] =(Byte) ((value>>16) & 0xFF);
    
    byte[2] =(Byte) ((value>>8) & 0xFF);
    
    byte[3] =(Byte) (value & 0xFF);
    
    return byte;
}
#pragma mark- private Method

-(void)decryptData:(long) encryptKey{
    NSString * encryptFile= @"/Users/xdf_yanqing/Downloads/outdemo01.ts";
    NSString * tempFile = @"/Users/xdf_yanqing/Desktop/MacDemo/123.ts";
    NSError * error;

    if ([NSFileManager.defaultManager fileExistsAtPath:tempFile]) {
        [NSFileManager.defaultManager removeItemAtPath:tempFile error:&error];
    }
    if ([NSFileManager.defaultManager fileExistsAtPath:encryptFile]){
        NSData * data = [[NSData alloc]initWithContentsOfFile:encryptFile];
//        int bufferSize = 1024;
    
        NSUInteger len = [data length];
        Byte * byteData = (Byte*)malloc(len);

        memcpy(byteData, [data bytes], len);
        NSOutputStream * dos = [[NSOutputStream alloc]initToMemory];
        [dos scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        dos.delegate = self;
        [dos open];
        Byte * decryptByteArray = [self getDecryptByte:encryptKey];
        for (int i = 0; i < len; i++) {
            Byte tsone =  byteData[i];
            int tsbyteT = tsone ^ (decryptByteArray[i % 4]);
            Byte s = (Byte)tsbyteT;
            Byte tsbyteArray[] = {s};
            NSLog(@"%d---%c--",i,s );
            [dos write:tsbyteArray maxLength:sizeof(tsbyteArray)];
        }
        NSData *newData = [dos propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        NSLog(@"%d",  [newData writeToFile:tempFile options:NSDataWritingWithoutOverwriting error:&error]);
        NSLog(@"%@",error);
        [dos close];
        [dos removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
    
}

-(NSString*)bytesToHexString:(Byte*)src{
    NSString * stringBuilder = @"";
    if (src == NULL) {
        return nil;
    }
    for (int i = 0; i < sizeof(src) ; i++) {
        int v = src[i]&0xFF;
        NSString * hv = [self getHexByDecimal:v];
        if (hv.length < 2) {
            hv = [hv stringByAppendingString:@"0"];
        }
        stringBuilder = [stringBuilder stringByAppendingString:hv];
    }
    return stringBuilder;
}

- (NSString *)getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}



-(void)decryptBase64:(NSString *)key withImage:(nonnull NSString *)path{
    
    NSData * data = [NSData dataWithContentsOfFile:path];
    Byte * SandBox = (Byte*)[data bytes];
    Byte a[791679] ;
    NSLog(@"%lu",data.length);
    long length = data.length;
    for (int i = 0;  i < length; i ++ ) {
        NSLog(@"%c",SandBox[i]);
        if (i>81) {
            a[i-81] = SandBox[i];
        }
    }
    NSLog(@"%s",a);
    NSData * s = [[NSData alloc]initWithBytes:a length:2831];
    path =    [path.stringByDeletingPathExtension stringByAppendingString:@"123.png"];
    NSLog(@"%@",path);
    [s writeToFile:path atomically:YES];

}

@end
