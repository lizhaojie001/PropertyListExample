//
//  main.m
//  Teeet
//
//  Created by xdf_yanqing on 12/24/20.
//
#include <dlfcn.h>
#include <mach-o/dyld.h>
#include <Foundation/Foundation.h>
#define MKDIR_EXISTS 1
#define MKDIR_SUCCESS 0
#define MKDIR_ERROR -1
#include <objc/runtime.h>
#import <Cocoa/Cocoa.h>

int os_rename(const char* old_path, const char* new_path) {
    NSString * oldPath = [[NSString alloc] initWithCString:old_path encoding: NSUTF8StringEncoding ];
    if  (![[NSFileManager defaultManager] fileExistsAtPath:oldPath] ) {
        printf("oldPath don't exit\n");
        return  -1;
    }
    
    NSString * newPath = [[NSString alloc] initWithCString:new_path encoding: NSUTF8StringEncoding ];
    NSError * error;
    if ([[NSFileManager defaultManager] copyItemAtPath:oldPath toPath:newPath error:&error]) {
        [[NSFileManager defaultManager] removeItemAtPath:oldPath error:&error];
        return 0;
    } else {
        NSLog(@"rename failed %@",error.localizedDescription);
        return -1;
    }
}


int os_copyfile(const char* file_in, const char* file_out)
{
    NSString * oldPath = [[NSString alloc] initWithCString:file_in encoding: NSUTF8StringEncoding ];
    if  (![[NSFileManager defaultManager] fileExistsAtPath:oldPath] ) {
        printf("file_in don't exit\n");
        return  -1;
    }
    
    NSString * newPath = [[NSString alloc] initWithCString:file_out encoding: NSUTF8StringEncoding ];
    NSError * error;
    if ([[NSFileManager defaultManager] copyItemAtPath:oldPath toPath:newPath error:&error]) {
        return 0;
    } else {
        NSLog(@"rename failed %@",error.localizedDescription);
        return -1;
    }
}

int os_safe_replace(const char* target, const char* from, const char* backup)
{
    NSString * targetPath = [[NSString alloc] initWithCString:target encoding: NSUTF8StringEncoding ];
    NSString * fromPath = [[NSString alloc] initWithCString:from encoding: NSUTF8StringEncoding ];
    NSString * backupPath = [[NSString alloc] initWithCString:backup encoding: NSUTF8StringEncoding ];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fromPath]) {
        NSLog(@"from file don't exist");
        return -1;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:targetPath]) {
        [[NSFileManager defaultManager] moveItemAtPath:targetPath toPath:backupPath error:nil];
    }
    
    if ([[NSFileManager defaultManager] copyItemAtPath:fromPath toPath:targetPath error:nil]) {
        return 0;
    }
    return -1;
}



static int os_get_path_internal(char *dst, size_t size, const char *name,
                NSSearchPathDomainMask domainMask)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
        NSApplicationSupportDirectory, domainMask, YES);

    if ([paths count] == 0)
        NSLog(@"Could not get home directory (platform-cocoa)");

    NSString *application_support = paths[0];
    const char *base_path = [application_support UTF8String];
    NSLog(@"%s",base_path);
    if (!name || !*name)
        return snprintf(dst, size, "%s", base_path);
    else
        return snprintf(dst, size, "%s/%s", base_path, name);
}




int os_mkdir(const char* path)
{
    NSString * filePath = [[NSString alloc] initWithCString:path encoding: NSUTF8StringEncoding ];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return MKDIR_EXISTS;
    }
    
    NSError * error;
    if ([[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:true attributes:nil error:&error]) {
        return MKDIR_SUCCESS;
    }
    NSLog(@"%@",error.localizedDescription);
    return  MKDIR_ERROR;
}


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


static char * os_get_path_ptr_internal(const char *name,
                      NSSearchPathDomainMask domainMask)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSApplicationSupportDirectory, domainMask, YES);
    if ([paths count] == 0) {
        NSLog(@"Could not get home directory (platform-cocoa)");
        return nil;
    }
    NSString *application_support = paths[0];
    
    NSString * Name = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
    
    application_support = [application_support stringByAppendingPathComponent:Name];
    static char dest[1024];
    strcpy(dest, [application_support UTF8String]);
    return dest;
}


int os_get_executable_path(char* dst, size_t size, const char* name)
{
    char exe[PATH_MAX];
    char abs_path[PATH_MAX];
    uint32_t sizet = sizeof(exe);
    
    if (_NSGetExecutablePath(exe, &sizet) != 0) {
        return -1;
    }

    if (!realpath(exe, abs_path)) {
        return -1;
    }
    
    unsigned long newLen = strlen(abs_path) + strlen(name) + 1;
    if ( newLen > size) {
         return  -1;
    }
    
    strcat(abs_path, "/");
    strcat(abs_path, name);
    strcpy(dst, abs_path);
    return (int)strlen(dst);
}


void * os_create_process(const char* file, const char* cmd)
{
    NSTask * task = [[NSTask alloc] init];
    NSString * path = [NSString stringWithCString:file encoding:NSUTF8StringEncoding];
    [task setLaunchPath:path];
    NSString * args = [[NSString alloc] initWithCString:cmd encoding:NSUTF8StringEncoding];
    [task setArguments:@[args]];
    [task launch];
    NSLog(@"启动进程 %@",task);
    task.terminationHandler = ^(NSTask* task) {
        NSLog(@"进程终止 %@",task);
    };
    void * p = (__bridge void *)task;
    return p;
}
void os_close_process(void *  handle)
{
    NSTask * task = (__bridge NSTask *)handle;
    [task terminate];
    NSLog(@"开启进程终止 %@",task);
    task = nil;
}

bool os_process_exists(void * handle){
    return false;
}



//int main(int argc, const char * argv[]) {
//    @autoreleasepool {


//        int a = os_rename(oldpath, newPath);
//        NSLog(@"os_rename = %d",a);
//        int b = os_safe_replace(oldpath, newPath, backup);
//        NSLog(@"os_safe_replace = %d",b);
//        int c = os_copyfile(newPath,backup);
//        NSLog(@"os_copyfile = %d",c);
//        char  bytes[1024];
//        NSLog(@"%lu",sizeof(bytes));
//        int d = os_get_path_internal(bytes, sizeof(bytes), "zuishuai1111", NSUserDomainMask);
//        printf("%d\n",d);
//        os_mkdir("/Users/xdf_yanqing/Desktop/111");
//        char * str =   os_get_path_ptr_internal("zuishuai1111", NSUserDomainMask);
//        NSLog(@"%s",str);
//        char buffer[1024];
//       NSLog(@" %d -- %s", os_get_executable_path(buffer, sizeof(buffer), "ttt"),buffer);
//
//       void * p =  os_create_process("/Applications/Roombox.app/Contents/MacOS/Roombox", "");
//
//        sleep(10);
//
//        os_close_process(p);
//
//        while (1) {
//
//        }
        
//        char buffer[1024];
//        os_get_path_internal("1233", sizeof(buffer), buffer, NSLocalDomainMask);
//        NSLog(@"%s", buffer );
//    }
//    return 0;
//}
