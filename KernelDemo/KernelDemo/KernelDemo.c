//
//  KernelDemo.c
//  KernelDemo
//
//  Created by xdf_yanqing on 2019/7/24.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

#include <mach/mach_types.h>
#include <libkern/libkern.h>
kern_return_t KernelDemo_start(kmod_info_t * ki, void *d);
kern_return_t KernelDemo_stop(kmod_info_t *ki, void *d);

kern_return_t KernelDemo_start(kmod_info_t * ki, void *d)
{
    printf("Hello world");
    return KERN_SUCCESS;
}

kern_return_t KernelDemo_stop(kmod_info_t *ki, void *d)
{
    printf("Bye Bye world");
    return KERN_SUCCESS;
}
