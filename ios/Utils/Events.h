#ifndef Events_h
#define Events_h

#import <UIKit/UIKit.h>

@interface Events: NSObject

+ (Events *)shared;

// Camera
@property (strong, nonatomic) NSString *CAMERA_OPENED;
@property (strong, nonatomic) NSString *CAMERA_CLOSED;

// Common
@property (strong, nonatomic) NSString *LOADED;
@property (strong, nonatomic) NSString *CANCELLED_BY_USER;

// Error
@property (strong, nonatomic) NSString *ERROR;

// Recorder
@property (strong, nonatomic) NSString *MANUALLY_SUBMITTED;
@property (strong, nonatomic) NSString *RECORDING_STARTED;
@property (strong, nonatomic) NSString *RECORDING_STOPPED;
@property (strong, nonatomic) NSString *COUNTDOWN;
@property (strong, nonatomic) NSString *RECORDING_PROGRESS;
@property (strong, nonatomic) NSString *READY_TO_RECORD;
@property (strong, nonatomic) NSString *RERECORD;

// Streaming
@property (strong, nonatomic) NSString *STREAMING_STARTED;
@property (strong, nonatomic) NSString *STREAMING_STOPPED;

// Camera hardware
@property (strong, nonatomic) NSString *NO_CAMERA;
@property (strong, nonatomic) NSString *HAS_CAMERA;

// Mic hardware
@property (strong, nonatomic) NSString *MIC_HEALTH;
@property (strong, nonatomic) NSString *NO_MIC;
@property (strong, nonatomic) NSString *HAS_MIC;

// Permissions
@property (strong, nonatomic) NSString *ACCESS_GRANTED;
@property (strong, nonatomic) NSString *ACCESS_FORBIDDEN;

// Uploader
@property (strong, nonatomic) NSString *UPLOADING_STARTED;
@property (strong, nonatomic) NSString *UPLOAD_PROGRESS;
@property (strong, nonatomic) NSString *VERIFIED;
@property (strong, nonatomic) NSString *PROCESSING;
@property (strong, nonatomic) NSString *PROCESSED;
@property (strong, nonatomic) NSString *UPLOADED;

// File selector
@property (strong, nonatomic) NSString *UPLOAD_SELECTED;

// Player
@property (strong, nonatomic) NSString *PLAYING;
@property (strong, nonatomic) NSString *PAUSED;
@property (strong, nonatomic) NSString *ENDED;
@property (strong, nonatomic) NSString *SEEK;
@property (strong, nonatomic) NSString *READY_TO_PLAY;

// QR scanner
@property (strong, nonatomic) NSString *QR_DECODED;

// SensorManager
@property (strong, nonatomic) NSString *LIGNT_SENSOR_LEVEL;

@end

#endif /* Events_h */
