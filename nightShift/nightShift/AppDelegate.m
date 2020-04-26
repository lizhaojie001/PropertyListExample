//
//  AppDelegate.m
//  nightShift
//
//  Created by xdf_yanqing on 2020/4/23.
//  Copyright © 2020 xdf_yanqing. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    CBBlueLightClient *client = [[CBBlueLightClient alloc] init];
    [client setStrength:0.5 commit:true];
    [client setEnabled:true];

}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
