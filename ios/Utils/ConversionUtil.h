#ifndef ConversionUtil_h
#define ConversionUtil_h

#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import <UIKit/UIKit.h>


@interface ConversionUtil : NSObject

+ (CacheConfig *)dataToCacheConfig:(NSDictionary *)data;
+ (NSDictionary *)dataFromCacheConfig:(CacheConfig *)config;
+ (UploadingConfig *)dataToUploadingConfig:(NSDictionary *)data;
+ (NSDictionary *)dataFromUploadingConfig:(UploadingConfig *)config;
+ (StopRecordingConfirmationDialogConfig *)dataToConfirmationDialogConfig:(NSDictionary *)data;
+ (NSDictionary *)dataFromConfirmationDialogConfig:(StopRecordingConfirmationDialogConfig *)config;

@end

#endif /* ConversionUtil_h */

