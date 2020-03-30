//
//  Audio.h
//  Recorder
//
//  Created by xdf_yanqing on 2020/1/2.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface Audio : NSObject {
    AudioStreamBasicDescription audioFormat;
}
@property (nonatomic, assign) AudioUnit rioUnit;
@property (nonatomic, assign) AudioBufferList bufferList;

+ (Audio *)sharedAudioManager;
- (void)start;
- (void)stop;
- (void)finished;

@end

NS_ASSUME_NONNULL_END
