#ifndef RecorderKeys_h
#define RecorderKeys_h

#import <UIKit/UIKit.h>

@interface RecorderKeys: NSObject

+ (RecorderKeys *)shared;

@property (strong, nonatomic) NSString *KEY_CACHE_SIZE;
@property (strong, nonatomic) NSString *KEY_CACHE_ROOT;

@property (strong, nonatomic) NSString *KEY_TITLE_RES_ID;
@property (strong, nonatomic) NSString *KEY_TITLE_TEXT;
@property (strong, nonatomic) NSString *KEY_MESSAGE_RES_ID;
@property (strong, nonatomic) NSString *KEY_MESSAGE_TEXT;
@property (strong, nonatomic) NSString *KEY_POSITIVE_BUTTON_RES_ID;
@property (strong, nonatomic) NSString *KEY_POSITIVE_BUTTON_TEXT;
@property (strong, nonatomic) NSString *KEY_NEGATIVE_BUTTON_RES_ID;
@property (strong, nonatomic) NSString *KEY_NEGATIVE_BUTTON_TEXT;

@property (strong, nonatomic) NSString *KEY_USE_WIFI_ONLY;
@property (strong, nonatomic) NSString *KEY_SYNC_INTERVAL;
@property (strong, nonatomic) NSString *KEY_TURN_OFF_UPLOADER;
@property (strong, nonatomic) NSString *KEY_START_AS_FOREGROUND;
@property (strong, nonatomic) NSString *KEY_LOST_CONNECTION_ACTION;

@end

#endif /* RecorderKeys_h */
