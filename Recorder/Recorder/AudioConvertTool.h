//
//  AudioConvertTool.h
//  MLRecodeAudio
//
//  Created by Mrlu on 19/10/2017.
//  Copyright © 2017 Mrlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioConvertTool : NSObject

/**
 get instance obj
 @return ConvertAudioFile instance
 */
+ (instancetype)sharedInstance;

/**
 ConvertMp3
 @param cafFilePath caf FilePath
 @param mp3FilePath mp3 FilePath
 @param sampleRate sampleRate (same record sampleRate set)
 @param callback callback result
 */
- (void)conventToMp3WithCafFilePath:(NSString *)cafFilePath
                        mp3FilePath:(NSString *)mp3FilePath
                         sampleRate:(int)sampleRate
                           callback:(void(^)(BOOL result))callback;

/**
 send end record signal
 */
- (void)sendEndRecord;


// Use this FUNC convent to mp3 after record
+ (void)conventToMp3WithCafFilePath:(NSString *)cafFilePath
                        mp3FilePath:(NSString *)mp3FilePath
                         sampleRate:(int)sampleRate
                           callback:(void(^)(BOOL result))callback;

@end
