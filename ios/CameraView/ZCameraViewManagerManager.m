#import <Foundation/Foundation.h>

#import "RCTBridge.h"
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import <React/RCTLog.h>
#import <UIKit/UIKit.h>
#import "ZCameraView.h"
#import "ZCameraViewManagerManager.h"
#import "RCTZCameraModule.h"
#import "RCTVideos.h"
#import "ZiggeoConstants.h"


ButtonConfig *parseButtonConfig(NSDictionary *dictionary) {
    ButtonConfig *config = [ButtonConfig new];
    id value;

    value = dictionary[@"imagePath"];
    if (value && [value isKindOfClass:[NSString class]]) {
        config.imagePath = (NSString *)value;
    }

    value = dictionary[@"selectedImagePath"];
    if (value && [value isKindOfClass:[NSString class]]) {
        config.selectedImagePath = (NSString *)value;
    }

    value = dictionary[@"scale"];
    if (value && [value isKindOfClass:[NSNumber class]]) {
        config.scale = [((NSNumber *)value) doubleValue];
    }

    value = dictionary[@"width"];
    if (value && [value isKindOfClass:[NSNumber class]]) {
        CGFloat *val = calloc(1, sizeof(CGFloat));
        *val = [((NSNumber *)value) doubleValue];
        config.width = val;
    }

    value = dictionary[@"height"];
    if (value && [value isKindOfClass:[NSNumber class]]) {
        CGFloat *val = calloc(1, sizeof(CGFloat));
        *val = [((NSNumber *)value) doubleValue];
        config.height = val;
    }

    return config;
}

RecorderInterfaceConfig *parseRecorderInterfaceConfig(NSDictionary *config) {
    RecorderInterfaceConfig *conf = [RecorderInterfaceConfig new];

    id recordButtonConfig = config[@"recordButton"];
    if (recordButtonConfig && [recordButtonConfig isKindOfClass:[NSDictionary class]]) {
        conf.recordButton = parseButtonConfig(recordButtonConfig);
    }
    
    id closeButtonConfig = config[@"closeButton"];
    if (closeButtonConfig && [closeButtonConfig isKindOfClass:[NSDictionary class]]) {
        conf.closeButton = parseButtonConfig(closeButtonConfig);
    }
    
    id cameraFlipButtonConfig = config[@"cameraFlipButton"];
    if (cameraFlipButtonConfig && [cameraFlipButtonConfig isKindOfClass:[NSDictionary class]]) {
        conf.cameraFlipButton = parseButtonConfig(cameraFlipButtonConfig);
    }
    
    return conf;
}

@implementation ZCameraViewManagerManager

RCT_EXPORT_MODULE();

RCT_EXPORT_VIEW_PROPERTY(style, NSString);
RCT_EXPORT_VIEW_PROPERTY(ref, NSString);

@synthesize bridge = _bridge;

- (UIView *)view 
{
    ZCameraView *view = [[ZCameraView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
    
    if ([ZiggeoConstants shared] != nil) {
        [ZiggeoConstants shared].connect.serverAuthToken = [RCTVideos serverAuthToken];
        [ZiggeoConstants shared].connect.clientAuthToken = [RCTVideos clientAuthToken];
        
        // todo? [m_ziggeo.config setRecorderCacheConfig:self.cacheConfig];

        ZiggeoRecorder* recorder = [[ZiggeoRecorder alloc] initWithZiggeoApplication:[ZiggeoConstants shared]];
        // settings controlsVisible to false also sets autostart, send immediately and max video duration.
        // Setting everything back because we will actually have custom UI  so these settings are not needed
        RecorderConfig *recorderConfig = [RecorderConfig new];
        [recorderConfig setShouldAutoStartRecording:true];
//        [recorderConfig setStartDelay:DEFAULT_START_DELAY];
        [recorderConfig setShouldDisableCameraSwitch:false];
//        [recorderConfig setVideoQuality:QUALITY_HIGH];
//        [recorderConfig setFacing:FACING_BACK];
        [recorderConfig setMaxDuration:0];
        [recorderConfig setShouldSendImmediately:false];
        [recorderConfig setIsPausedMode:true];
//        [recorderConfig.resolution setAspectRatio:DEFAULT_ASPECT_RATIO];
        [recorderConfig setShouldConfirmStopRecording:true];
        recorder.videoPreview = nil; // we don't need any UI because it's a customizable component

        [RCTZCameraModule setLastZiggeoRecorder:recorder];

        /*
        recorder.coverSelectorEnabled = self->_coverSelectorEnabled;
        recorder.cameraFlipButtonVisible = self->_cameraFlipButtonVisible;
        recorder.cameraDevice = self->_camera;
        recorder.recorderDelegate = context;
        recorder.extraArgsForCreateVideo = self->_additionalRecordingParams;
        recorder.useLiveStreaming = self->_liveStreamingEnabled;
        recorder.recordingQuality = self->_quality;
        recorder.interfaceConfig = parseRecorderInterfaceConfig(self.interfaceConfig);
        recorder.autostartRecordingAfterSeconds = self.autostartRecordingAfter;
        recorder.startDelay = self.startDelay;
        if(self->_videoWidth != 0) recorder.videoWidth = (int)self.videoWidth;
        if(self->_videoHeight != 0) recorder.videoHeight = (int)self.videoHeight;
        if(self->_videoBitrate != 0) recorder.videoBitrate = (int)self.videoBitrate;
        if(self->_audioSampleRate != 0) recorder.audioSampleRate = (int)self.audioSampleRate;
        if(self->_audioBitrate != 0) recorder.audioBitrate = (int)self.audioBitrate;
        if(self->_additionalThemeParams)
        {
            if(recorder.extraArgsForCreateVideo) {
                NSMutableDictionary* merged = [[NSMutableDictionary alloc] initWithDictionary:recorder.extraArgsForCreateVideo];
                [merged addEntriesFromDictionary:self->_additionalThemeParams];
                recorder.extraArgsForCreateVideo = merged;
            }
            else recorder.extraArgsForCreateVideo = self->_additionalThemeParams;
        }
        recorder.maxRecordedDurationSeconds = self->_maxRecordingDuration;
        if(recorder.extraArgsForCreateVideo && ([@"true" isEqualToString:recorder.extraArgsForCreateVideo[@"hideRecorderControls"]] || [[recorder.extraArgsForCreateVideo valueForKey:@"hideRecorderControls"] boolValue] ))
        {
            recorder.controlsVisible = false;
        }
        */

        // todo? m_ziggeo.videos.delegate = context;
        UIView *recorderView = recorder.view;
        view.recorder = recorder;

        [view addSubview:recorderView];
        recorderView.translatesAutoresizingMaskIntoConstraints = false;

        [view.leadingAnchor constraintEqualToAnchor:recorderView.leadingAnchor].active = true;
        [view.trailingAnchor constraintEqualToAnchor:recorderView.trailingAnchor].active = true;
        [view.topAnchor constraintEqualToAnchor:recorderView.topAnchor].active = true;
        [view.bottomAnchor constraintEqualToAnchor:recorderView.bottomAnchor].active = true;
    }

    return view;
}

- (NSArray<NSString *> *)supportedEvents
{
    return @[
        @"RecordingStarted",
        @"RecordingStopped",
    ];
}

- (NSArray *) customDirectEventTypes {
    return @[
        @"onFrameChange"
    ];
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

@end;
