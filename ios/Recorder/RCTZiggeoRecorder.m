//
//  RCTZiggeoRecorder.m
//
//  Copyright © 2017 Ziggeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTZiggeoRecorder.h"
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import <React/RCTLog.h>
#import "ZiggeoRecorderContext.h"
#import "ZiggeoConstants.h"
#import "ZiggeoQRScannerContext.h"
#import "ConversionUtil.h"
#import "ThemeKeys.h"
#import "Events.h"
#import "Keys.h"

@implementation RCTZiggeoRecorder {
    int width;
    int height;
}

RCT_EXPORT_MODULE();


- (NSDictionary *)constantsToExport {
    return kZiggeoConstants;
}

- (NSArray<NSString *> *)supportedEvents {
    return [[NSArray alloc] initWithObjects:
            Events.shared.CAMERA_OPENED,
            Events.shared.CAMERA_CLOSED,
            // Common
            Events.shared.LOADED,
            Events.shared.CANCELLED_BY_USER,

            // Error
            Events.shared.ERROR,

            // Recorder
            Events.shared.MANUALLY_SUBMITTED,
            Events.shared.RECORDING_STARTED,
            Events.shared.RECORDING_STOPPED,
            Events.shared.COUNTDOWN,
            Events.shared.RECORDING_PROGRESS,
            Events.shared.READY_TO_RECORD,
            Events.shared.RERECORD,

            // Streaming
            Events.shared.STREAMING_STARTED,
            Events.shared.STREAMING_STOPPED,

            // Camera hardware
            Events.shared.NO_CAMERA,
            Events.shared.HAS_CAMERA,

            // Mic hardware
            Events.shared.MIC_HEALTH,
            Events.shared.NO_MIC,
            Events.shared.HAS_MIC,

            // Permissions
            Events.shared.ACCESS_GRANTED,
            Events.shared.ACCESS_FORBIDDEN,

            // Uploader
            Events.shared.UPLOADING_STARTED,
            Events.shared.UPLOAD_PROGRESS,
            Events.shared.VERIFIED,
            Events.shared.PROCESSING,
            Events.shared.PROCESSED,
            Events.shared.UPLOADED,

            // File selector
            Events.shared.UPLOAD_SELECTED,

            // Player
            Events.shared.PLAYING,
            Events.shared.PAUSED,
            Events.shared.ENDED,
            Events.shared.SEEK,
            Events.shared.READY_TO_PLAY,

            // QR scanner
            Events.shared.QR_DECODED,

            // SensorManager
            Events.shared.LIGNT_SENSOR_LEVEL,
            nil];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (void)showPresentViewController:(UIViewController *)viewController  {
    UIViewController *parentController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while(parentController.presentedViewController && parentController != parentController.presentedViewController) {
        parentController = parentController.presentedViewController;
    }
    [parentController presentViewController:viewController animated:true completion:nil];
}

- (void)applyAdditionalParams:(NSDictionary*)map context:(ZiggeoRecorderContext*)context {
    context.extraArgs = map;
    
    if (map != nil) {
        if ([map objectForKey:@"max_duration"] != nil) {
            context.maxAllowedDurationInSeconds = [[map objectForKey:@"max_duration"] intValue];
        }
        if ([map objectForKey:@"enforce_duration"] != nil) {
            context.enforceDuration = [[map objectForKey:@"enforce_duration"] boolValue];
        }
    }
}


RCT_EXPORT_METHOD(setAppToken:(NSString *)token)
{
    RCTLogInfo(@"application token set: %@", token);
    _appToken = token;
    
    [ZiggeoConstants setAppToken:_appToken];
    [[ZiggeoConstants sharedContext] setRecorder:self];
}

RCT_EXPORT_METHOD(setServerAuthToken:(NSString *)token)
{
    RCTLogInfo(@"server auth token set: %@", token);
    _serverAuthToken = token;
}

RCT_EXPORT_METHOD(setClientAuthToken:(NSString *)token)
{
    RCTLogInfo(@"server auth token set: %@", token);
    _clientAuthToken = token;
}

RCT_EXPORT_METHOD(setSensorManager:(NSDictionary *)data)
{
    if ([ZiggeoConstants shared] == nil) return;
}

RCT_EXPORT_METHOD(setRecorderCacheConfig:(NSDictionary *)map)
{
    if ([ZiggeoConstants shared] == nil) return;
    CacheConfig *cacheConfig = [ConversionUtil dataToCacheConfig:map];
    [[ZiggeoConstants shared].recorderConfig setCacheConfig:cacheConfig];
}

RCT_EXPORT_METHOD(setUploadingConfig:(NSDictionary *)map)
{
    if ([ZiggeoConstants shared] == nil) return;
    UploadingConfig *uploadingConfig = [ConversionUtil dataToUploadingConfig:map];
    [[ZiggeoConstants shared] setUploadingConfig:uploadingConfig];
}

RCT_EXPORT_METHOD(setLiveStreamingEnabled:(BOOL)enabled)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setLiveStreaming:enabled];
}

RCT_EXPORT_METHOD(setAutostartRecordingAfter:(NSInteger)seconds)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setShouldAutoStartRecording:true];
    [[ZiggeoConstants shared].recorderConfig setStartDelay:(int)seconds];
}

RCT_EXPORT_METHOD(setStartDelay:(NSInteger)seconds)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setStartDelay:(int)seconds];
}

/**
 * @deprecated Use `setExtraArgsForRecorder` instead.
 */
RCT_EXPORT_METHOD(setExtraArgsForCreateVideo:(NSDictionary*)map)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setExtraArgs:map];
}

RCT_EXPORT_METHOD(setExtraArgsForRecorder:(NSDictionary*)map)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setExtraArgs:map];
}

RCT_EXPORT_METHOD(setThemeArgsForRecorder:(NSDictionary*)map)
{
    if ([ZiggeoConstants shared] == nil) return;
    if ([map.allKeys containsObject:ThemeKeys.shared.KEY_HIDE_RECORDER_CONTROLS]) {
        BOOL hideControls = [map[ThemeKeys.shared.KEY_HIDE_RECORDER_CONTROLS] boolValue];
        [[ZiggeoConstants shared].recorderConfig.style setHideControls:hideControls];
    }
}

RCT_EXPORT_METHOD(setCoverSelectorEnabled:(BOOL)enabled)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setShouldEnableCoverShot:enabled];
}

RCT_EXPORT_METHOD(setMaxRecordingDuration:(NSInteger)seconds)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setMaxDuration:(long)seconds];
}

RCT_EXPORT_METHOD(setVideoWidth:(NSInteger)videoWidth)
{
    if (height < 0) {
        height = 0;
    }
    width = (int)videoWidth;
    if ([ZiggeoConstants shared] == nil) return;
    if (width == 0) {
        [ZiggeoConstants shared].recorderConfig.resolution = [[VideoSize alloc] initWithWidth:0 height:0];
    } else {
        [ZiggeoConstants shared].recorderConfig.resolution = [[VideoSize alloc] initWithWidth:width height:height];
    }
}

RCT_EXPORT_METHOD(setVideoHeight:(NSInteger)videoHeight)
{
    if (width < 0) {
        width = 0;
    }
    height = (int)videoHeight;
    if ([ZiggeoConstants shared] == nil) return;
    if (height == 0) {
        [ZiggeoConstants shared].recorderConfig.resolution = [[VideoSize alloc] initWithWidth:0 height:0];
    } else {
        [ZiggeoConstants shared].recorderConfig.resolution = [[VideoSize alloc] initWithWidth:width height:height];
    }
}

RCT_EXPORT_METHOD(setVideoBitrate:(NSInteger)videoBitrate)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setVideoBitrate:(int)videoBitrate];
}

RCT_EXPORT_METHOD(setAudioSampleRate:(NSInteger)audioSampleRate)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setAudioSampleRate:(int)audioSampleRate];
}

RCT_EXPORT_METHOD(setAudioBitrate:(NSInteger)audioBitrate)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setAudioBitrate:(int)audioBitrate];
}

RCT_EXPORT_METHOD(setBlurMode:(BOOL)enabled)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setBlurMode:enabled];
}

RCT_EXPORT_METHOD(setPausableMode:(BOOL)enabled)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setIsPausedMode:enabled];
}

RCT_EXPORT_METHOD(setCameraSwitchEnabled:(BOOL)visible)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setShouldDisableCameraSwitch:!visible];
}

RCT_EXPORT_METHOD(setSendImmediately:(BOOL)sendImmediately)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setShouldSendImmediately:sendImmediately];
}

RCT_EXPORT_METHOD(setQuality:(int)quality)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setVideoQuality:quality];
}

RCT_EXPORT_METHOD(setCamera:(int)facing)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].recorderConfig setFacing:facing];
}

RCT_EXPORT_METHOD(setStopRecordingConfirmationDialogConfig:(NSDictionary*)map)
{
    if ([ZiggeoConstants shared] == nil) return;
    StopRecordingConfirmationDialogConfig *stopRecordingConfirmationDialogConfig = [ConversionUtil dataToConfirmationDialogConfig:map];
    [[ZiggeoConstants shared].recorderConfig setStopRecordingConfirmationDialogConfig:stopRecordingConfirmationDialogConfig];
}

// MARK: - Videos
RCT_REMAP_METHOD(record,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;

    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] record];
    });
}

RCT_EXPORT_METHOD(trimVideo:(NSString *)videoUrl
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;

    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] trimVideo:videoUrl];
    });
}

RCT_REMAP_METHOD(startImageRecorder,
                 resolver1:(RCTPromiseResolveBlock)resolve
                 rejecter1:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] startImageRecorder];
    });
}

RCT_EXPORT_METHOD(showImage:(NSArray *)imageTokens
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;

    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] showImages:imageTokens];
    });
}

RCT_EXPORT_METHOD(showImages:(NSArray *)imageTokens
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;

    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] showImages:imageTokens];
    });
}

RCT_REMAP_METHOD(startAudioRecorder,
                 resolver2:(RCTPromiseResolveBlock)resolve
                 rejecter2:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;

    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] startAudioRecorder];
    });
}

RCT_EXPORT_METHOD(playAudio:(NSString *)audioToken
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] playAudio:audioToken];
    });
}

RCT_EXPORT_METHOD(playAudios:(NSArray *)audioTokens
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] playAudios:audioTokens];
    });
}

RCT_EXPORT_METHOD(startAudioPlayer:(NSArray *)audioToken
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] playAudios:audioToken];
    });
}

RCT_EXPORT_METHOD(startScreenRecorder:(NSString *)appGroup
                  preferredExtension:(NSString *)preferredExtension
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;

    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] startScreenRecorderWithAppGroup:appGroup preferredExtension:preferredExtension];
    });
}

RCT_EXPORT_METHOD(uploadFromPath:(NSString*)fileName
                  argsMap:(NSDictionary*)map
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;
    
    if (fileName != nil) {
        [[ZiggeoConstants shared] uploadFromPath:fileName
                                            data:map
                                        callback:^(NSDictionary *jsonObject, NSURLResponse *response, NSError *error) {
        } progress:^(int totalBytesSent, int totalBytesExpectedToSend) {
        } confirmCallback:^(NSDictionary *jsonObject, NSURLResponse *response, NSError *error) {
        }];
    } else {
        reject(@"ERR_NOFILE", @"empty filename", [NSError errorWithDomain:@"recorder" code:0 userInfo:@{@"ERR_NOFILE": @"empty filename"}]);
    }
}

RCT_EXPORT_METHOD(uploadFromFileSelector:(NSDictionary*)map
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;

    [self applyAdditionalParams:map context:[ZiggeoConstants sharedContext]];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZiggeoConstants shared] startFileSelector];
    });
}

RCT_EXPORT_METHOD(cancelCurrentUpload:(BOOL)delete_file
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;
    
    [[ZiggeoConstants shared] cancelUpload:@"" :delete_file];
}

RCT_EXPORT_METHOD(cancelUploadByPath:(NSString *)path
                  delete_file:(BOOL)delete_file
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [ZiggeoConstants sharedContext].resolveBlock = resolve;
    [ZiggeoConstants sharedContext].rejectBlock = reject;
    
    [[ZiggeoConstants shared] cancelUpload:path :delete_file];
}

RCT_EXPORT_METHOD(startQrScanner:(NSDictionary*)map
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    ZiggeoQRScannerContext *context = [[ZiggeoQRScannerContext alloc] init];
    [context setRecorder:self];
    Ziggeo *ziggeo = [[Ziggeo alloc] init];
    [ziggeo setQRScannerDelegate:context];
    
    BOOL close = true;
    if ([map.allKeys containsObject:Keys.shared.CLOSE_AFTER_SUCCESSFUL_SCAN]) {
        close = map[Keys.shared.CLOSE_AFTER_SUCCESSFUL_SCAN];
    }
    [ziggeo.qrScannerConfig setShouldCloseAfterSuccessfulScan:close];

    context.resolveBlock = resolve;
    context.rejectBlock = reject;

    dispatch_async(dispatch_get_main_queue(), ^{
        [ziggeo startQrScanner];
    });
}

// MARK: - Get functions
RCT_REMAP_METHOD(getStopRecordingConfirmationDialogConfig,
                 resolver3:(RCTPromiseResolveBlock)resolve
                 rejecter3:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else {
        StopRecordingConfirmationDialogConfig *stopRecordingConfirmationDialogConfig = [[ZiggeoConstants shared].recorderConfig getStopRecordingConfirmationDialogConfig];
        resolve([ConversionUtil dataFromConfirmationDialogConfig:stopRecordingConfirmationDialogConfig]);
    }
}

RCT_REMAP_METHOD(getBlurMode,
                 resolver4:(RCTPromiseResolveBlock)resolve
                 rejecter4:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithBool:[[ZiggeoConstants shared].recorderConfig getBlurMode]]);
}

RCT_REMAP_METHOD(getPausableMode,
                 resolver5:(RCTPromiseResolveBlock)resolve
                 rejecter5:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithBool:[[ZiggeoConstants shared].recorderConfig getIsPausedMode]]);
}

RCT_REMAP_METHOD(getVideoWidth,
                 resolver6:(RCTPromiseResolveBlock)resolve
                 rejecter6:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithInt:[[ZiggeoConstants shared].recorderConfig.resolution getWidth]]);
}

RCT_REMAP_METHOD(getVideoHeight,
                 resolver7:(RCTPromiseResolveBlock)resolve
                 rejecter7:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithInt:[[ZiggeoConstants shared].recorderConfig.resolution getHeight]]);
}

RCT_REMAP_METHOD(getVideoBitrate,
                 resolver8:(RCTPromiseResolveBlock)resolve
                 rejecter8:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithInt:[[ZiggeoConstants shared].recorderConfig getVideoBitrate]]);
}

RCT_REMAP_METHOD(getAudioSampleRate,
                 resolver9:(RCTPromiseResolveBlock)resolve
                 rejecter9:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithInt:[[ZiggeoConstants shared].recorderConfig getAudioSampleRate]]);
}

RCT_REMAP_METHOD(getAudioBitrate,
                 resolver10:(RCTPromiseResolveBlock)resolve
                 rejecter10:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithInt:[[ZiggeoConstants shared].recorderConfig getAudioBitrate]]);
}

RCT_REMAP_METHOD(getLiveStreamingEnabled,
                 resolver11:(RCTPromiseResolveBlock)resolve
                 rejecter11:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithBool:[[ZiggeoConstants shared].recorderConfig getIsLiveStreaming]]);
}

RCT_REMAP_METHOD(getAutostartRecording,
                 resolver12:(RCTPromiseResolveBlock)resolve
                 rejecter12:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithBool:[[ZiggeoConstants shared].recorderConfig getShouldAutoStartRecording]]);
}

RCT_REMAP_METHOD(getStartDelay,
                 resolver13:(RCTPromiseResolveBlock)resolve
                 rejecter13:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithInt:[[ZiggeoConstants shared].recorderConfig getStartDelay]]);
}

RCT_REMAP_METHOD(getExtraArgsForRecorder,
                 resolver14:(RCTPromiseResolveBlock)resolve
                 rejecter14:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([[ZiggeoConstants shared].recorderConfig getExtraArgs]);
}

RCT_REMAP_METHOD(getCoverSelectorEnabled,
                 resolver15:(RCTPromiseResolveBlock)resolve
                 rejecter15:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithBool:[[ZiggeoConstants shared].recorderConfig getShouldEnableCoverShot]]);
}

RCT_REMAP_METHOD(getMaxRecordingDuration,
                 resolver16:(RCTPromiseResolveBlock)resolve
                 rejecter16:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithLong:[[ZiggeoConstants shared].recorderConfig getMaxDuration]]);
}

RCT_REMAP_METHOD(getCameraSwitchEnabled,
                 resolver17:(RCTPromiseResolveBlock)resolve
                 rejecter17:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithBool:![[ZiggeoConstants shared].recorderConfig getShouldDisableCameraSwitch]]);
}

RCT_REMAP_METHOD(getSendImmediately,
                 resolver18:(RCTPromiseResolveBlock)resolve
                 rejecter18:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithBool:[[ZiggeoConstants shared].recorderConfig getShouldSendImmediately]]);
}

RCT_REMAP_METHOD(getCamera,
                 resolver19:(RCTPromiseResolveBlock)resolve
                 rejecter19:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithInt:[[ZiggeoConstants shared].recorderConfig getFacing]]);
}

RCT_REMAP_METHOD(getQuality,
                 resolver20:(RCTPromiseResolveBlock)resolve
                 rejecter20:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([NSNumber numberWithInt:[[ZiggeoConstants shared].recorderConfig getVideoQuality]]);
}

RCT_REMAP_METHOD(getRecorderCacheConfig,
                 resolver21:(RCTPromiseResolveBlock)resolve
                 rejecter21:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([ConversionUtil dataFromCacheConfig:[[ZiggeoConstants shared].recorderConfig getCacheConfig]]);
}

RCT_REMAP_METHOD(getUploadingConfig,
                 resolver22:(RCTPromiseResolveBlock)resolve
                 rejecter22:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([ConversionUtil dataFromUploadingConfig:[[ZiggeoConstants shared] uploadingConfig]]);
}

@end
