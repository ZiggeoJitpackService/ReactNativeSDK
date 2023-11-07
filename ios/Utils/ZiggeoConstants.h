//
//  Constants.h
//
//  Copyright © 2017 Ziggeo. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#import <Foundation/Foundation.h>
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import "ZiggeoRecorderContext.h"


#define kZiggeoConstants  @{  \
    @"rearCamera": [NSNumber numberWithInt:0], \
    @"frontCamera": [NSNumber numberWithInt:1], \
    @"highQuality": [NSNumber numberWithInt:0], \
    @"mediumQuality": [NSNumber numberWithInt:1], \
    @"lowQuality": [NSNumber numberWithInt:2], \
    @"ERR_UNKNOWN": @"ERR_UNKNOWN", \
    @"ERR_DURATION_EXCEEDED": @"ERR_DURATION_EXCEEDED", \
    @"ERR_FILE_DOES_NOT_EXIST": @"ERR_FILE_DOES_NOT_EXIST", \
    @"ERR_PERMISSION_DENIED": @"ERR_PERMISSION_DENIED", \
    @"max_duration": @"max_duration", \
    @"enforce_duration": @"enforce_duration", \
};

@interface ZiggeoConstants: NSObject

+ (void)setAppToken:(NSString *)appToken;
+ (Ziggeo *)shared;
+ (ZiggeoRecorderContext *)sharedContext;

@end


#endif /* Constants_h */
