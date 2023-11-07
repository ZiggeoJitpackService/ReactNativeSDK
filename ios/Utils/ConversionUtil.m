#import "ConversionUtil.h"
#import <Foundation/Foundation.h>
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import "ZiggeoConstants.h"
#import "RecorderKeys.h"
#import "FileSelectorKeys.h"


@implementation ConversionUtil

+ (CacheConfig *)dataToCacheConfig:(NSDictionary *)data {
    CacheConfig *config = [CacheConfig new];
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_CACHE_SIZE]) {
        [config setMaxCacheSize:[data[RecorderKeys.shared.KEY_CACHE_SIZE] intValue]];
    }
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_CACHE_ROOT]) {
        [config setCacheRoot:[data[RecorderKeys.shared.KEY_CACHE_ROOT] stringValue]];
    }

    return config;
}

+ (NSDictionary *)dataFromCacheConfig:(CacheConfig *)config {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:config.maxCacheSize], RecorderKeys.shared.KEY_CACHE_SIZE,
                          config.cacheRoot, RecorderKeys.shared.KEY_CACHE_ROOT,
                          nil];
    return dict;
}

+ (UploadingConfig *)dataToUploadingConfig:(NSDictionary *)data {
    UploadingConfig *config = [UploadingConfig new];
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_USE_WIFI_ONLY]) {
        [config setShouldUseWifiOnly:[data[RecorderKeys.shared.KEY_USE_WIFI_ONLY] boolValue]];
    }
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_SYNC_INTERVAL]) {
        [config setSyncInterval:[data[RecorderKeys.shared.KEY_SYNC_INTERVAL] longValue]];
    }
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_TURN_OFF_UPLOADER]) {
        [config setShouldTurnOffUploader:[data[RecorderKeys.shared.KEY_TURN_OFF_UPLOADER] boolValue]];
    }
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_START_AS_FOREGROUND]) {
        [config setShouldStartAsForeground:[data[RecorderKeys.shared.KEY_START_AS_FOREGROUND] boolValue]];
    }
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_LOST_CONNECTION_ACTION]) {
        [config setLostConnectionAction:[data[RecorderKeys.shared.KEY_LOST_CONNECTION_ACTION] intValue]];
    }

    return config;
}

+ (NSDictionary *)dataFromUploadingConfig:(UploadingConfig *)config {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithBool:config.shouldUseWifiOnly], RecorderKeys.shared.KEY_USE_WIFI_ONLY,
                          [NSNumber numberWithLong:config.syncInterval], RecorderKeys.shared.KEY_SYNC_INTERVAL,
                          [NSNumber numberWithBool:config.shouldTurnOffUploader], RecorderKeys.shared.KEY_TURN_OFF_UPLOADER,
                          [NSNumber numberWithBool:config.shouldStartAsForeground], RecorderKeys.shared.KEY_START_AS_FOREGROUND,
                          [NSNumber numberWithInt:config.lostConnectionAction], RecorderKeys.shared.KEY_LOST_CONNECTION_ACTION,
                          nil];
    return dict;
}

+ (FileSelectorConfig *)dataToFileSelectorConfig:(NSDictionary *)data {
    FileSelectorConfig *config = [FileSelectorConfig new];
    
    if ([data.allKeys containsObject:FileSelectorKeys.shared.KEY_MAX_DURATION]) {
        [config setMaxDuration:[data[FileSelectorKeys.shared.KEY_MAX_DURATION] longValue]];
    }
    
    if ([data.allKeys containsObject:FileSelectorKeys.shared.KEY_MIN_DURATION]) {
        [config setMinDuration:[data[FileSelectorKeys.shared.KEY_MIN_DURATION] longValue]];
    }
    
    if ([data.allKeys containsObject:FileSelectorKeys.shared.KEY_ALLOW_MULTIPLE_SELECTION]) {
        [config setShouldAllowMultipleSelection:[data[FileSelectorKeys.shared.KEY_ALLOW_MULTIPLE_SELECTION] boolValue]];
    }
    
    if ([data.allKeys containsObject:FileSelectorKeys.shared.KEY_MEDIA_TYPE]) {
        [config setMediaType:[data[FileSelectorKeys.shared.KEY_MEDIA_TYPE] intValue]];
    }
    
    if ([data.allKeys containsObject:FileSelectorKeys.shared.KEY_EXTRA_ARGS]) {
        [config setExtraArgs:data[FileSelectorKeys.shared.KEY_EXTRA_ARGS]];
    }

    return config;
}

+ (NSDictionary *)dataFromFileSelectorConfig:(FileSelectorConfig *)config {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithLong:config.maxDuration], FileSelectorKeys.shared.KEY_MAX_DURATION,
                          [NSNumber numberWithLong:config.minDuration], FileSelectorKeys.shared.KEY_MIN_DURATION,
                          [NSNumber numberWithBool:config.shouldAllowMultipleSelection], FileSelectorKeys.shared.KEY_ALLOW_MULTIPLE_SELECTION,
                          [NSNumber numberWithInt:config.mediaType], FileSelectorKeys.shared.KEY_MEDIA_TYPE,
                          config.extraArgs, FileSelectorKeys.shared.KEY_EXTRA_ARGS,
                          nil];
    return dict;
}

+ (StopRecordingConfirmationDialogConfig *)dataToConfirmationDialogConfig:(NSDictionary *)data {
    StopRecordingConfirmationDialogConfig *config = [StopRecordingConfirmationDialogConfig new];
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_TITLE_TEXT]) {
        [config setTitleText:[data[RecorderKeys.shared.KEY_TITLE_TEXT] stringValue]];
    }
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_MESSAGE_TEXT]) {
        [config setMesText:[data[RecorderKeys.shared.KEY_MESSAGE_TEXT] stringValue]];
    }
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_POSITIVE_BUTTON_TEXT]) {
        [config setPosBtnText:[data[RecorderKeys.shared.KEY_POSITIVE_BUTTON_TEXT] stringValue]];
    }
    
    if ([data.allKeys containsObject:RecorderKeys.shared.KEY_NEGATIVE_BUTTON_TEXT]) {
        [config setNegBtnText:[data[RecorderKeys.shared.KEY_NEGATIVE_BUTTON_TEXT] stringValue]];
    }

    return config;
}

+ (NSDictionary *)dataFromConfirmationDialogConfig:(StopRecordingConfirmationDialogConfig *)config {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          config.titleText, RecorderKeys.shared.KEY_TITLE_TEXT,
                          config.mesText, RecorderKeys.shared.KEY_MESSAGE_TEXT,
                          config.posBtnText, RecorderKeys.shared.KEY_POSITIVE_BUTTON_TEXT,
                          config.negBtnText, RecorderKeys.shared.KEY_NEGATIVE_BUTTON_TEXT,
                          nil];
    return dict;
}

@end
