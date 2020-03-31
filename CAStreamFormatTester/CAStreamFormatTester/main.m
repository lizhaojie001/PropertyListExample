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
        fileTypeAndFormat.mFileType = kAudioFileMP3Type;
        fileTypeAndFormat.mFormatID = kAudioFormatFLAC;
        OSStatus audioErr = noErr;
        UInt32 infoSize = 0;
        
        audioErr = AudioFileGetGlobalInfoSize(kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat, sizeof(fileTypeAndFormat), &fileTypeAndFormat, &infoSize);
            if (audioErr != noErr) {
                UInt32 err4cc = CFSwapInt32HostToBig(audioErr); NSLog (@"audioErr = %4.4s", (char*)&err4cc);
//                kAudioFileUnsupportedDataFormatError
            }
//        assert(audioErr == noErr);
        
        AudioStreamBasicDescription * asbds = malloc(infoSize);
        audioErr = AudioFileGetGlobalInfo(kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat, sizeof(fileTypeAndFormat), &fileTypeAndFormat, &infoSize, asbds);
        int asbdCount = infoSize / sizeof(AudioStreamBasicDescription);
        for (int i = 0; i < asbdCount ; i ++ ) {
            UInt32 formate4cc = CFSwapInt32HostToBig(asbds[i].mFormatID);
            NSLog(@"%d : mFormateId : %4.4s , mFormatFlags : %d , mBitsPerChannel : %d", i,(char *)&formate4cc,asbds[i].mFormatFlags,asbds[i].mBitsPerChannel);
        }
        NSLog(@"end");
        free(asbds);
    }
    return 0;
}
