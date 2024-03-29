#ifndef ZCameraView_h
#define ZCameraView_h

#import <UIKit/UIKit.h>
#import "RCTEventDispatcher.h"
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>

@interface ZCameraView: UIView

@property (nonatomic, assign) NSString *style;
@property (nonatomic, assign) NSString *ref;
@property (nonatomic, assign) ZiggeoRecorder *recorder;

@property (nonatomic) UIViewController<VideoPreviewProtocol>* videoPreview;
@property (nonatomic) bool coverSelectorEnabled;
@property (nonatomic) bool sendImmediately;
@property (nonatomic) bool cameraFlipButtonVisible;
@property (nonatomic) bool useLiveStreaming;
@property (nonatomic) bool controlsVisible;
@property (nonatomic) bool showFaceOutline;
//@property (nonatomic) bool showLightIndicatorproperty (nonatomic) bool showSoundIndicator;
@property (nonatomic) RecorderInterfaceConfig *interfaceConfig;
@property (nonatomic) UIImagePickerControllerCameraDevice cameraDevice;
@property (nonatomic) NSDictionary* extraArgsForCreateVideo;
@property (nonatomic) double maxRecordedDurationSeconds;
@property (nonatomic) double autostartRecordingAfterSeconds;
@property (nonatomic) double startDelay;
@property (nonatomic) AVLayerVideoGravity videoGravity;
//resolution
@property (nonatomic) int videoWidth;
@property (nonatomic) int videoHeight;
@property (nonatomic) int videoQuality;
@property (nonatomic) int videoBitrate;
@property (nonatomic) int audioSampleRate;
@property (nonatomic) int audioBitrate;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;

@end;

#endif /* ZCameraView_h */
