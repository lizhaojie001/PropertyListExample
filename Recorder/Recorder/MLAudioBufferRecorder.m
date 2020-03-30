//
//  MLAudioBufferRecorder.m
//  BJEducation
//
//  Created by Randy on 14/12/2.
//  Copyright (c) 2014年 com.bjhl. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "MLAudioBufferRecorder.h"
#import "MLRecordAudio.h"
#import "lame.h"
#include <sys/sysctl.h>


@interface MLAudioBufferRecorder () {
    FILE *mp3File;
    lame_t lame;
}

@property (strong, nonatomic) NSString *recordedTmpFile;
@property (assign, nonatomic)BOOL isCancel;
@property (assign, atomic) NSInteger recordTime;
@property (assign, atomic)BOOL isActive;
@property (strong, nonatomic) dispatch_queue_t lameQueue;

@end

@implementation MLAudioBufferRecorder

static void AQInputCallback (void                   * inUserData,
                             AudioQueueRef          inAudioQueue,
                             AudioQueueBufferRef    inBuffer,
                             const AudioTimeStamp   * inStartTime,
                             UInt32          inNumPackets,
                             const AudioStreamPacketDescription * inPacketDesc)
{
    __weak MLAudioBufferRecorder * engine = (__bridge MLAudioBufferRecorder *) inUserData;
    if (engine.aqc.run)
    {
        engine.recordTime = inStartTime->mSampleTime / engine.sampleRate;
        if (inNumPackets > 0)
        {
            [engine processAudioBuffer:inBuffer withQueue:inAudioQueue];
        }
        AudioQueueEnqueueBuffer(engine.aqc.queue, inBuffer, 0, NULL);
    }
}

- (id)init {
    return [self initWithSampleRate:kSamplingRate];
}

- (id) initWithSampleRate:(float)sr {
    self = [super init];
    if (self) {
        _aqc.mDataFormat.mSampleRate = sr;
        _aqc.mDataFormat.mFormatID = kAudioFormatLinearPCM;
        _aqc.mDataFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
        _aqc.mDataFormat.mFramesPerPacket = 1;
        _aqc.mDataFormat.mChannelsPerFrame = kNumberChannels;
        _aqc.mDataFormat.mBitsPerChannel = kBitsPerChannels;
        _aqc.mDataFormat.mBytesPerPacket = kBytesPerFrame;
        _aqc.mDataFormat.mBytesPerFrame = kBytesPerFrame;
        _aqc.frameSize = kFrameSize;
        
        lame = lame_init();
        lame_set_in_samplerate(lame, _aqc.mDataFormat.mSampleRate);
        lame_set_num_channels(lame, kNumberChannels);
        lame_set_mode(lame, 1);
        lame_set_brate(lame, 128);// 压缩的比特率为128K
        
        //低设备
//        if ([UIDevice isLowDevice]) {
//            lame_set_quality(lame, 5);
//        }
//        else
            lame_set_quality(lame, 2);
        lame_init_params(lame);
        _aqc.run = 1;
        _lameQueue = dispatch_queue_create("com.audioBufferRecorder.lame", DISPATCH_QUEUE_SERIAL);
        _isLameFinish = YES;
    }
    
    return self;
}

- (void) dealloc {
#ifdef DEBUG
    NSLog(@"%@ dealloc", self);
#endif
    [self cancelRecord];
    lame_t lameTmp = lame;
    dispatch_async(self.lameQueue, ^{
        if (lameTmp) {
            lame_close(lameTmp);
        }
    });
}

- (Float64)sampleRate {
    return _aqc.mDataFormat.mSampleRate;
}

- (void)openMp3File {
    mp3File = fopen([self.recordedTmpFile cStringUsingEncoding:1], "wb");
}

- (BOOL)isRecording {
    return self.isActive;
}

- (void)_startRecord:(AudioBufferRecoderCallback)callback {
    self.isCancel = NO;
    _aqc.run = 1;
//    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
//    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
//    [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
//    [audioSession setActive:YES error: nil];
    self.isActive = YES;
    self.recordedTmpFile = [NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"mp3"]];
    __weak MLAudioBufferRecorder *weakSelf = self;
    
    dispatch_async(weakSelf.lameQueue, ^{
        weakSelf.isLameFinish = NO;
        [weakSelf openMp3File];
    });
    OSStatus status = AudioQueueNewInput(&_aqc.mDataFormat, AQInputCallback, (__bridge void *)(weakSelf), NULL, kCFRunLoopCommonModes, 0, &_aqc.queue);
    if (status != errSecSuccess) {
        callback(NO);
        return;
    }
    for (int i=0;i<kNumberBuffers;i++) {
        status = AudioQueueAllocateBuffer(_aqc.queue, (UInt32)_aqc.frameSize, &_aqc.mBuffers[i]);
        status = AudioQueueEnqueueBuffer(_aqc.queue, _aqc.mBuffers[i], 0, NULL);
    }
    status = AudioQueueStart(_aqc.queue, NULL);
    if (status != errSecSuccess) {
//        self.finishCallback(self.recordedTmpFile, [NSString stringWithFormat:@"录音失败 错误code：%d",(int)status],0,NO,NO);
        callback(NO);
    } else {
        self.recordTime = 0;
        callback(true);
    }
}

- (void)startRecord:(AudioBufferRecoderCallback)callback {
//    [self authorizePermission:^(bool granted, AVAudioSessionRecordPermission permission) {
//        if (!granted) {
//            if (permission == AVAudioSessionRecordPermissionUndetermined) {
//                AVAudioSession *session = [AVAudioSession sharedInstance];
//                NSError *error;
//                [session setCategory:@"AVAudioSessionCategoryPlayAndRecord" error:&error];
//                [session requestRecordPermission:^(BOOL granted) {
//                    if (callback) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            if (granted) {
//                                [self _startRecord:callback];
//                            } else {
//                                callback(false);
//                            }
//                        });
//                    }
//                }];
//            } else {
//                NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
//                NSString *message = [NSString stringWithFormat:@"请到 设置 -> 隐私 -> %@ 重新启用 %@ 访问.",@"麦克风", appName];
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"跳转" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//                    [[UIApplication sharedApplication] openURL:appSettings options:[NSDictionary dictionary] completionHandler:nil];
//#else
//                    [[UIApplication sharedApplication] openURL:appSettings];
//#endif
//                }];
//                [alert addAction:cancelAction];
//                [alert addAction:sureAction];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
//                });
//            }
//            if (callback) {
//                callback(granted);
//            }
//        } else {
            [self _startRecord:callback];
//        }
//    }];
}

- (void)timerAction {
    if (self.recordTime >= self.duration && self.duration>0) {
        [self stopRecord];
    } else if(self.remainingCallback && self.isActive) {
        self.remainingCallback(self.recordTime);
    }
}

- (void)stopRecord {
    [self _stopRecord];
    [self _stopLame];
    if (!self.isCancel) {
        if (self.finishCallback) {
            self.finishCallback(self.recordedTmpFile, self.recordedTmpFile,self.recordTime,YES,NO);
        }
    }
}

- (void)cancelRecord {
    self.isCancel = YES;
    [self _stopRecord];
}

- (void)_stopLame {
    __weak MLAudioBufferRecorder *weakSelf = self;
    FILE *mp3FileTmp = mp3File;
    dispatch_async(weakSelf.lameQueue, ^{
        if (weakSelf && mp3FileTmp) {
            fclose(mp3FileTmp);
        }
        weakSelf.isLameFinish = YES;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (weakSelf.finishCallback) {
//                weakSelf.finishCallback(weakSelf.recordedTmpFile, weakSelf.recordedTmpFile,weakSelf.recordTime,YES,YES);
//            }
//        });
    });
    mp3File = NULL;
}

- (void)_stopRecord {
    _aqc.run = 0;
    
    AudioQueueStop(_aqc.queue, true);
    AudioQueueDispose(_aqc.queue, true);
//    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
//    if (self.isActive) {
//        [audioSession setActive:NO error: nil];
//        self.isActive = NO;
//    }
}

- (void)enableLevelMetering:(BOOL)enable {
    int32_t on = enable;
    OSStatus rc = AudioQueueSetProperty(_aqc.queue, kAudioQueueProperty_EnableLevelMetering, &on, sizeof(on));
    NSLog(@"kAudioQueueProperty_EnableLevelMetering ret:%d", (int)rc);
}

- (double)audioMeter {
    UInt32 dataSize = sizeof(AudioQueueLevelMeterState) * _aqc.mDataFormat.mChannelsPerFrame;
    AudioQueueLevelMeterState *levels = (AudioQueueLevelMeterState*)malloc(dataSize);
    
    OSStatus rc = AudioQueueGetProperty(_aqc.queue, kAudioQueueProperty_CurrentLevelMeter, levels, &dataSize);
    if (rc) {
        free(levels);    // This works since in this sole box one channel always has an mAveragePower of 0.   relapse channelAvg;
        NSLog(@"NoiseLeveMeter>>takeSample - AudioQueueGetProperty(CurrentLevelMeter) returned %d", rc);
        return 0;
    }
    
    double channelAvg = 0;
    for (int i = 0; i < _aqc.mDataFormat.mChannelsPerFrame; i++) {
        channelAvg += levels[i].mPeakPower;
    }
    free(levels);    // This works since in this sole box one channel always has an mAveragePower of 0.   relapse channelAvg;
    
    return channelAvg / _aqc.mDataFormat.mChannelsPerFrame;
}

- (void) processAudioBuffer:(AudioQueueBufferRef) buffer withQueue:(AudioQueueRef) queue {
    __weak MLAudioBufferRecorder *theModel = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [theModel timerAction];
    });
    UInt32 dataSize = buffer->mAudioDataByteSize;
    long size = buffer->mAudioDataByteSize / _aqc.mDataFormat.mBytesPerFrame;
    t_sample * data = (t_sample *) buffer->mAudioData;
    t_sample * copyData = (t_sample *)malloc(dataSize);
    memcpy(copyData, data, dataSize);
    lame_t lameTmp = lame;
    FILE *mp3FileTmp = mp3File;
    dispatch_async(theModel.lameQueue, ^{
        @try {
            if (theModel && mp3FileTmp) {
                int write;
                unsigned char mp3_buffer[dataSize];
                write = lame_encode_buffer(lameTmp, copyData,NULL, (int)size, mp3_buffer, 0);
                fwrite(mp3_buffer, write, 1, mp3FileTmp);
            }
        }
        @catch (NSException *exception) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [theModel _stopRecord];
                [theModel _stopLame];
                theModel.finishCallback(self.recordedTmpFile, [NSString stringWithFormat:@"转码失败 原因：%@",[exception description]],0,NO,NO);
            });
        }
        @finally {
            
        }
        free(copyData);
    });
}

//- (void)authorizePermission:(void(^)(bool granted, AVAudioSessionRecordPermission permission)) authorizationHandler {
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    if ([audioSession respondsToSelector:@selector(recordPermission)]) {
//        AVAudioSessionRecordPermission permission = [audioSession recordPermission];
//        switch (permission) {
//            case AVAudioSessionRecordPermissionGranted: {
//                if (authorizationHandler) {
//                    authorizationHandler(true, permission);
//                }
//            } break;
//            case AVAudioSessionRecordPermissionDenied: {
//                if (authorizationHandler) {
//                    authorizationHandler(false, permission);
//                }
//            } break;
//            case AVAudioSessionRecordPermissionUndetermined: {
//                if (authorizationHandler) {
//                    authorizationHandler(false, permission);
//                }
//            } break;
//        }
//    }
//}


@end

