#import <Foundation/Foundation.h>
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import "RCTZCameraModule.h"

@implementation RCTZCameraModule

RCT_EXPORT_MODULE();

static ZiggeoRecorder *lastZiggeoRecorder;
static RecorderConfig *lastZiggeoConfig;

RCT_EXPORT_METHOD(startRecording:(NSString *)path maxDuration:(int)maxDuration) {
    if (lastZiggeoConfig != nil && lastZiggeoRecorder != nil) {
        lastZiggeoConfig.maxDuration = (double)maxDuration;
        [lastZiggeoRecorder startRecordingToFile:path];
    }
}

RCT_EXPORT_METHOD(stopRecording) {
    if (lastZiggeoRecorder != nil) {
        [lastZiggeoRecorder stopRecording];
    }
}

- (NSArray<NSString *> *)supportedEvents
{
    return @[
    ];
}

+ (void)setLastZiggeoRecorder:(ZiggeoRecorder *) recorder {
    lastZiggeoRecorder = recorder;
}


@end
