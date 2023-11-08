#import "Events.h"

@implementation Events

static Events *m_events = NULL;

+ (Events *)shared {
    @synchronized(self) {
        if (m_events == NULL) {
            m_events = [[Events alloc] init];
        }
    }
    return m_events;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Camera
        self.CAMERA_OPENED = @"CameraOpened";
        self.CAMERA_CLOSED = @"CameraClosed";

        // Common
        self.LOADED = @"Loaded";
        self.CANCELLED_BY_USER = @"CancelledByUser";

        // Error
        self.ERROR = @"Error";

        // Recorder
        self.MANUALLY_SUBMITTED = @"ManuallySubmitted";
        self.RECORDING_STARTED = @"RecordingStarted";
        self.RECORDING_STOPPED = @"RecordingStopped";
        self.COUNTDOWN = @"Countdown";
        self.RECORDING_PROGRESS = @"RecordingProgress";
        self.READY_TO_RECORD = @"ReadyToRecord";
        self.RERECORD = @"Rerecord";

        // Streaming
        self.STREAMING_STARTED = @"StreamingStarted";
        self.STREAMING_STOPPED = @"StreamingStopped";

        // Camera hardware
        self.NO_CAMERA = @"NoCamera";
        self.HAS_CAMERA = @"HasCamera";

        // Mic hardware
        self.MIC_HEALTH = @"MicrophoneHealth";
        self.NO_MIC = @"NoMicrophone";
        self.HAS_MIC = @"HasMicrophone";

        // Permissions
        self.ACCESS_GRANTED = @"AccessGranted";
        self.ACCESS_FORBIDDEN = @"AccessForbidden";

        // Uploader
        self.UPLOADING_STARTED = @"UploadingStarted";
        self.UPLOAD_PROGRESS = @"UploadProgress";
        self.VERIFIED = @"Verified";
        self.PROCESSING = @"Processing";
        self.PROCESSED = @"Processed";
        self.UPLOADED = @"Uploaded";

        // File selector
        self.UPLOAD_SELECTED = @"UploadSelected";

        // Player
        self.PLAYING = @"Playing";
        self.PAUSED = @"Paused";
        self.ENDED = @"Ended";
        self.SEEK = @"Seek";
        self.READY_TO_PLAY = @"ReadyToPlay";

        // QR scanner
        self.QR_DECODED = @"QrDecoded";

        // SensorManager
        self.LIGNT_SENSOR_LEVEL = @"lightSensorLevel";
    }
    return self;
}

@end
