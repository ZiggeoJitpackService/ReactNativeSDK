#ifndef Keys_h
#define Keys_h

#import <UIKit/UIKit.h>

@interface Keys: NSObject

+ (Keys *)shared;

@property (strong, nonatomic) NSString *BYTES_SENT;
@property (strong, nonatomic) NSString *BYTES_TOTAL;
@property (strong, nonatomic) NSString *FILE_NAME;
@property (strong, nonatomic) NSString *PATH;
@property (strong, nonatomic) NSString *TYPE;
@property (strong, nonatomic) NSString *QR;
@property (strong, nonatomic) NSString *TOKEN;
@property (strong, nonatomic) NSString *STREAM_TOKEN;
@property (strong, nonatomic) NSString *PERMISSIONS;
@property (strong, nonatomic) NSString *SOUND_LEVEL;
@property (strong, nonatomic) NSString *SECONDS_LEFT;
@property (strong, nonatomic) NSString *MILLIS_PASSED;
@property (strong, nonatomic) NSString *MILLIS;
@property (strong, nonatomic) NSString *FILES;
@property (strong, nonatomic) NSString *VALUE;
@property (strong, nonatomic) NSString *CLOSE_AFTER_SUCCESSFUL_SCAN;

@end

#endif /* Keys_h */
