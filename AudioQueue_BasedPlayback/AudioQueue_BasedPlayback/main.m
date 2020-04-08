//
//  main.m
//  AudioQueue_BasedPlayback
//
//  Created by xdf_yanqing on 2020/4/7.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define kNumberPlaybackBuffers 3

#define kPlaybackFileLocation CFSTR("/Users/xdf_yanqing/Documents/未命名文件夹/1222.caf")


#pragma mark user data struct
    //5.2
typedef struct MyPlayer {
    AudioFileID playbackFile;
    SInt64 packetPosition;
    UInt32 numPacketsToRead;
    AudioStreamPacketDescription *packetDescs;
    Boolean isDone;
} MyPlayer;
#pragma mark utility functions
    //4.2
    //5.14
    //5.15
static void CheckError(OSStatus error, const char *operation) {
    if (error == noErr) return;
    char errorString[20];
    // See if it appears to be a 4-char-code
    *(UInt32 *)(errorString + 1) = CFSwapInt32HostToBig(error);
    if (isprint(errorString[1]) && isprint(errorString[2]) &&
        isprint(errorString[3]) && isprint(errorString[4])) {
        errorString[0] = errorString[5] = '\'';
        errorString[6] = '\0';
    } else
        // No, format it as an integer
        sprintf(errorString, "%d", (int)error);
    fprintf(stderr, "Error: %s (%s)\n", operation, errorString);
    exit(1);
}
#pragma mark playback callback function
    //5.16-5.19
static void MyAQOutputCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer){
    
}

#pragma mark main function


int main(int argc, const char * argv[]) {
    @autoreleasepool {
      //open file
        // 5.3-5.4
        MyPlayer player = {0};
        CFURLRef myFileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, kPlaybackFileLocation, kCFURLPOSIXPathStyle, false);
        CheckError(AudioFileOpenURL(myFileURL, kAudioFileReadPermission, 0, &player.playbackFile), "AudioFileOpenURL failed");
        CFRelease(myFileURL);
        //set up format
        //5.5
        AudioStreamBasicDescription dataFormat;
        UInt32 propSize = sizeof(dataFormat);
        CheckError(AudioFileGetProperty(player.playbackFile, kAudioFilePropertyDataFormat,
                                        &propSize, &dataFormat), "Couldn't get file's data format");
        
        char errorString[20];
        *(UInt32 *)(errorString + 1) = CFSwapInt32HostToBig(dataFormat.mFormatID);
        if (isprint(errorString[1]) && isprint(errorString[2]) &&
            isprint(errorString[3]) && isprint(errorString[4])) {
            errorString[0] = errorString[5] = '\'';
            errorString[6] = '\0';
            NSLog(@"formatID : %s",errorString);
        }
        
        //set up queue
        //5.6-5.10
        AudioQueueRef queue;
        CheckError(AudioQueueNewOutput(&dataFormat,  MyAQOutputCallback, &player,
                                       NULL,
                                       NULL,
                                       0,
                                       &queue), "AudioQueueNewOutput failed");
        
        UInt32 bufferByteSize;
        CalculateBytesForTime(player.playbackFile,
                                                     dataFormat,
                                                     0.5,
                                                     &bufferByteSize, &player.numPacketsToRead);
        
        bool isFormatVBR = (dataFormat.mBytesPerPacket == 0 ||
                            dataFormat.mFramesPerPacket == 0);
        if (isFormatVBR)
            player.packetDescs = (AudioStreamPacketDescription*)
            malloc(sizeof(AudioStreamPacketDescription) * player.numPacketsToRead);
        else
            player.packetDescs = NULL;
        
        MyCopyEncoderCookieToQueue(player.playbackFile, queue);
        
        //start queue
        //5.11-5.12
        
        //clean up
        //5.13
        
    }
    return 0;
}


