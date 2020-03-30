//
//  main.m
//  CAToneFileGenerator
//
//  Created by xdf_yanqing on 2020/3/24.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>



#define SAMPLE_RATE 1000
#define DURATION 5.0
#define FILENAME_FORMAT @"%0.3f-sine.aif"// @"%0.3f-saw.aif"//@"%0.3f-square.aif"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        if (argc < 2) {
            NSLog(@"Uage : CAToneFileGenerator n \n (Where n is tone in Hz)");
            return -1;
        }
        //atof 将字符串转为浮点数
        double hz = atof(argv[1]);
        assert(hz > 0);
        NSLog(@"generating %f Hz tone",hz);
        
        NSString * fileName = [NSString stringWithFormat:FILENAME_FORMAT,hz];
        NSString * filePath = [[[NSFileManager defaultManager] currentDirectoryPath] stringByAppendingPathComponent:fileName];
        NSURL * fileURL = [NSURL fileURLWithPath:filePath];
        
        //准备 格式
        
        AudioStreamBasicDescription asbd;
        //C 库函数 void *memset(void *str, int c, size_t n) 复制字符 c（一个无符号字符）到参数 str 所指向的字符串的前 n 个字符。
        memset(&asbd, 0, sizeof(asbd)); //初始化
        asbd.mSampleRate = SAMPLE_RATE;
        asbd.mFormatID = kAudioFormatLinearPCM; //非压缩
        asbd.mFormatFlags = kAudioFormatFlagIsBigEndian | kAudioFormatFlagIsPacked | kAudioFormatFlagIsSignedInteger;
        asbd.mBitsPerChannel = 16 ; //16-bit 的samples
        asbd.mChannelsPerFrame = 1;
        asbd.mFramesPerPacket = 1;
        asbd.mBytesPerFrame = 1 * 16 / 8 ; // 2 bytes
        asbd.mBytesPerPacket =  asbd.mFramesPerPacket *  asbd.mBytesPerFrame; //因为LPCM不使用packets,只针对可变比特率,所以 mChannelsPerFrame == mFramesPerPacket
        
        // 创建文件
        
        AudioFileID audioFile;
        OSStatus audioErr = noErr;
        audioErr = AudioFileCreateWithURL((__bridge CFURLRef)fileURL, kAudioFileAIFFType, &asbd, kAudioFileFlags_EraseFile, &audioFile);
        
        assert(audioErr == noErr);
        
        //开始 采样
        long maxSampleCount = SAMPLE_RATE * DURATION;
        long sampleCount = 0;
        uint32 bytesToWrite = 2;
        double waveLengthInSamples = SAMPLE_RATE / hz;
        while (sampleCount < maxSampleCount) {
            for (int i = 0 ; i < waveLengthInSamples ;  i ++ ) {
                // 方波
                
                SInt16 sample = CFSwapInt16HostToBig ((SInt16) SHRT_MAX * sin (2 * M_PI *
                                                                               (i / waveLengthInSamples)));
//                SInt16 sample = CFSwapInt16BigToHost(((i/waveLengthInSamples) * SHRT_MAX * 2) - SHRT_MAX);
//                if ( i < waveLengthInSamples / 2) {
//                    sample = CFSwapInt16BigToHost(SHRT_MAX);
//                } else {
//                    sample = CFSwapInt16BigToHost(SHRT_MIN);
//                }
                audioErr = AudioFileWriteBytes(audioFile, false, sampleCount * 2 , &bytesToWrite, &sample);
                assert(audioErr == noErr);
                sampleCount++;
            }
        }
        audioErr = AudioFileClose(audioFile);
        assert(audioErr == noErr);
        NSLog(@"write %ld samples " , sampleCount);
        
    }
    return 0;
}
