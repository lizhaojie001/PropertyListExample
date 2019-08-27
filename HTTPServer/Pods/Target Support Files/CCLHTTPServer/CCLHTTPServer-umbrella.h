#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CCLHTTPServerInterface.h"
#import "CCLHTTPServerResponse.h"
#import "CCLHTTPServer.h"
#import "CCLHTTPView.h"

FOUNDATION_EXPORT double CCLHTTPServerVersionNumber;
FOUNDATION_EXPORT const unsigned char CCLHTTPServerVersionString[];

