//
//  main.m
//  CAStreamFormatTester
//
//  Created by macbook pro on 2020/3/28.
//  Copyright © 2020 macbook pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

void CheckError(OSStatus error, const char *operation) {
    if (error == noErr) return;
    char errorString[20];
    // See if it appears to be a 4-char-code
    *(UInt32 *)(errorString + 1) = CFSwapInt32HostToBig(error);
    if (isprint(errorString[1]) && isprint(errorString[2]) &&
        isprint(errorString[3]) && isprint(errorString[4])) { errorString[0] = errorString[5] = '\''; errorString[6] = '\0';
    } else// No, format it as an integer
        sprintf(errorString, "%d", (int)error);
    fprintf(stderr, "Error: %s (%s)\n", operation, errorString); exit(1);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
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
        CheckError(audioErr, "设置格式");
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
 
