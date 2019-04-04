//
//  AudioUnitViewController.m
//  audio
//
//  Created by xdf_yanqing on 2019/3/18.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

#import "AudioUnitViewController.h"
#import "audioAudioUnit.h"

@interface AudioUnitViewController ()

@end

@implementation AudioUnitViewController {
    AUAudioUnit *audioUnit;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if (!audioUnit) {
        return;
    }
    
    // Get the parameter tree and add observers for any parameters that the UI needs to keep in sync with the AudioUnit
}

- (AUAudioUnit *)createAudioUnitWithComponentDescription:(AudioComponentDescription)desc error:(NSError **)error {
    audioUnit = [[audioAudioUnit alloc] initWithComponentDescription:desc error:error];
    
    return audioUnit;
}

@end
