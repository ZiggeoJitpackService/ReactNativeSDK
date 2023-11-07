#ifndef FileSelectorKeys_h
#define FileSelectorKeys_h

#import <UIKit/UIKit.h>

@interface FileSelectorKeys: NSObject

+ (FileSelectorKeys *)shared;

@property (strong, nonatomic) NSString *KEY_MAX_DURATION;
@property (strong, nonatomic) NSString *KEY_MIN_DURATION;
@property (strong, nonatomic) NSString *KEY_ALLOW_MULTIPLE_SELECTION;
@property (strong, nonatomic) NSString *KEY_MEDIA_TYPE;
@property (strong, nonatomic) NSString *KEY_EXTRA_ARGS;

@end

#endif /* FileSelectorKeys_h */
