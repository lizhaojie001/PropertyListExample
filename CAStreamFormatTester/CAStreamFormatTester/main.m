//
//  main.m
//  CAStreamFormatTester
//
//  Created by macbook pro on 2020/3/28.
//  Copyright © 2020 macbook pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        AudioFileTypeAndFormatID fileTypeAndFormat;
        fileTypeAndFormat.mFileType = kAudioFileAIFFType;
        fileTypeAndFormat.mFormatID = kAudioFormatLinearPCM;
        OSStatus audioErr = noErr;
        UInt32 infoSize = 0;
        
        audioErr = AudioFileGetGlobalInfoSize(kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat, sizeof(fileTypeAndFormat), &fileTypeAndFormat, &infoSize);
//        assert(infoSize == noErr);
        
        AudioStreamBasicDescription * asbds = malloc(infoSize);
        audioErr = AudioFileGetGlobalInfo(kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat, sizeof(fileTypeAndFormat), &fileTypeAndFormat, &infoSize, asbds);
        int asbdCount = infoSize / sizeof(AudioStreamBasicDescription);
        for (int i = 0; i < asbdCount ; i ++ ) {
            UInt32 formate4cc = CFSwapInt32HostToBig(asbds[i].mFormatID);
            NSLog(@"%d : mFormateId : %4.4s , mFormatFlags : %d , mBitsPerChannel : %d", i,(char *)&formate4cc,asbds[i].mFormatFlags,asbds[i].mBitsPerChannel);
        }
        free(asbds);
    }
    return 0;
}
