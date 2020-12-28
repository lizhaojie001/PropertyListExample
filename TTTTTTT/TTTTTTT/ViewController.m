//
//  ViewController.m
//  TTTTTTT
//
//  Created by xdf_yanqing on 12/28/20.
//

#import "ViewController.h"
#include <dlfcn.h>
#include <mach-o/dyld.h>
#import <TTTest/Person.h>
void* os_dlopen(const char* path)
{
    NSString * libP = [[NSString alloc] initWithCString:path encoding: NSUTF8StringEncoding ];
    if (![[NSFileManager defaultManager] fileExistsAtPath:libP]) {
        return nil;
    }
    
    void * lib_handle = dlopen(path, RTLD_GLOBAL | RTLD_NOW);
    if ( nil == lib_handle ) {
        NSLog(@"os_dlopen failed");
    }
    return lib_handle;
}


void* os_dlsym(void* module, const char* func)
{
    void * func_pointer = dlsym(module, func);
    if ( nil == func_pointer) {
        NSLog(@"os_dlsym failed");
    }
    return func_pointer;
}

void os_dlclose(void* module)
{
    dlclose(module);
}


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)load:(id)sender {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"TTTest" ofType:@"framework"];
   void * handle =  os_dlopen([[path stringByAppendingPathComponent:@"TTTest"] UTF8String]);
    Class class = NSClassFromString(@"Person");
    if (class) {
        id object = [[class alloc] init];
        [(Person*)object doSomething];
    }
    os_dlclose(handle);
}




@end
