//
//  RecordAudio.m
//
//  Created by Randy on 14-11-27.
//  Copyright (c) 2014年 com.bjhl. All rights reserved.
//

#import "MLRecordAudio.h"
#import <AVFoundation/AVFoundation.h>
#import "lame.h"
#import "AudioConvertTool.h"

@interface BJCFTimer : NSObject
{
    __weak id target;
    SEL selector;
}

@property (nonatomic,strong)NSTimer* timer;
+ (BJCFTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector forMode:(NSString *)mode;
- (void)invalidate;

@end

@implementation BJCFTimer

-(void)time {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([target respondsToSelector:selector]) {
        [target performSelector:selector];
    }
#pragma clang diagnostic pop
}

- (void)dealloc {
    [self invalidate];
}

- (void)invalidate {
    [self.timer invalidate];
    _timer = nil;
    target = nil;
    selector = nil;
}

+ (BJCFTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector forMode:(NSString *)mode {
    BJCFTimer* timer = [[BJCFTimer alloc] init];
    if (timer)
    {
        timer->target = aTarget;
        timer->selector = aSelector;
        timer.timer = [NSTimer timerWithTimeInterval:ti target:timer selector:@selector(time) userInfo:nil repeats:YES];
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer: timer.timer forMode:mode];
    }
    return timer;
}
@end

@interface MLRecordAudio ()<AVAudioRecorderDelegate>

@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) NSString *recordedTmpFile;
@property (strong, nonatomic) NSString *recordedCafTmpFile;
@property (assign, nonatomic) BOOL isCancel;
@property (strong, nonatomic) BJCFTimer *timer;

@end

@implementation MLRecordAudio

- (void)dealloc {
    [self cancelRecord];
    [self.recorder deleteRecording];
    [self.recorder setDelegate:nil];
}

-(id)init {
    self = [super init];
    if (self) {
        self.duration = 180;
    }
    return self;
}

- (BOOL)isRecording {
    if (self.recorder){
        return self.recorder.isRecording;
    }
    return false;
}


- (void) stopRecord {
    if (self.recorder.isRecording) {
        [self.recorder stop];
    }
//    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
//    [audioSession setActive:NO error: nil];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void) startRecord {
    self.isCancel = NO;
    NSDictionary *recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
                                       [NSNumber numberWithFloat:44100.00], AVSampleRateKey,
                                       [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                       [NSNumber numberWithInt:16], AVEncoderBitRateKey,
                                      [NSNumber numberWithInt:AVAudioQualityMin],
                                   AVEncoderAudioQualityKey,
                                       nil];
    
    self.recordedCafTmpFile = [NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]];
    self.recordedTmpFile = [NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"mp3"]];
    NSLog(@"Using File called: %@",self.recordedCafTmpFile);
    NSError *error;
//    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
//    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
//    [audioSession setActive:YES error: nil];
    self.recorder = [[ AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.recordedCafTmpFile] settings:recordSetting error:&error];
    if (!error) {
        [self.recorder setDelegate:self];
        self.recorder.meteringEnabled=YES;
        [self.recorder recordForDuration:self.duration];
        
        if (self.remainingCallback) {
            self.timer = [BJCFTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(remainingTimerAction) forMode:NSRunLoopCommonModes];
        }
    } else {
        self.finishCallback(self.recordedCafTmpFile, error.localizedFailureReason, 0, NO, NO);
    }
}

-(void)cancelRecord {
    self.isCancel = YES;
    [self stopRecord];
}

- (void)remainingTimerAction {
    if (self.remainingCallback) {
        NSTimeInterval time = self.recorder.currentTime;
        self.remainingCallback(time);
    }
}

- (void)setRemainingCallBack:(BJRecordRemainingTime)remainingCallback {
    self.remainingCallback = remainingCallback;
}

- (void)setFinishCallBack:(MLRecordAudioFinish)finishCallback {
    self.finishCallback = finishCallback;
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    [self.timer invalidate];
    self.timer = nil;
    if (!self.isCancel) {
        NSString *messageStr = nil;
        if (flag) {
            messageStr = self.recordedTmpFile;
            int sampleRate = [[self.recorder.settings objectForKey:AVSampleRateKey] intValue];
            [AudioConvertTool conventToMp3WithCafFilePath:self.recordedCafTmpFile mp3FilePath:self.recordedTmpFile sampleRate:sampleRate callback:^(BOOL result) {
                if (self.finishCallback) {
                    self.finishCallback(self.recordedTmpFile, messageStr, self.recorder.currentTime, flag, result);
                }
            }];
        } else {
            messageStr = @"录制音频失败";
            if (self.finishCallback) {
                self.finishCallback(self.recordedCafTmpFile, messageStr, self.recorder.currentTime, flag, NO);
            }
        }
    }
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    [self.timer invalidate];
    self.timer = nil;
    if (!self.isCancel && self.finishCallback)
        self.finishCallback(self.recordedCafTmpFile, error.localizedFailureReason, 0, NO, NO);
}

@end
