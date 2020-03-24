//
//  main.m
//  CAMetadata
//
//  Created by xdf_yanqing on 2020/3/20.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "NSDictionary+UTF8.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        if (argc < 2 ) {
            printf("Usage : CAMetadata /full/path/audiofile \n");
            return -1;
        }
        
        NSString * audioFilePath = [[NSString stringWithUTF8String:argv[1]] stringByExpandingTildeInPath];
        NSURL * audioURL = [NSURL fileURLWithPath:audioFilePath];
        AudioFileID audioFile;
        OSStatus theErr = noErr;
        theErr = AudioFileOpenURL((__bridge CFURLRef)audioURL, kAudioFileReadPermission, 0, &audioFile);
        assert(theErr == noErr);
        uint32 dictionarySize = 0;
        theErr = AudioFileGetPropertyInfo(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, 0);
        assert(theErr == noErr);
        CFDictionaryRef dictionary;

        theErr = AudioFileGetProperty(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, &dictionary);
        assert(theErr == noErr);
        NSLog(@"dictionary %@" , (__bridge NSDictionary *)dictionary);
        CFRelease(dictionary);
        theErr = AudioFileClose(audioFile);
        assert(theErr == noErr);
    }
    return 0;
}
