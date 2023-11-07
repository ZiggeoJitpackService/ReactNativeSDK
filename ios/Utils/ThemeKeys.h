#ifndef ThemeKeys_h
#define ThemeKeys_h

#import <UIKit/UIKit.h>

@interface ThemeKeys: NSObject

+ (ThemeKeys *)shared;

@property (strong, nonatomic) NSString *KEY_HIDE_RECORDER_CONTROLS;
@property (strong, nonatomic) NSString *KEY_HIDE_PLAYER_CONTROLS;
@property (strong, nonatomic) NSString *KEY_PLAYER_CONTROLLER_STYLE;
@property (strong, nonatomic) NSString *KEY_PLAYER_TEXT_COLOR;
@property (strong, nonatomic) NSString *KEY_PLAYER_UNPLAYED_COLOR;
@property (strong, nonatomic) NSString *KEY_PLAYER_PLAYED_COLOR;
@property (strong, nonatomic) NSString *KEY_PLAYER_BUFFERED_COLOR;
@property (strong, nonatomic) NSString *KEY_PLAYER_TINT_COLOR;
@property (strong, nonatomic) NSString *KEY_PLAYER_MUTE_OFF_DRAWABLE;
@property (strong, nonatomic) NSString *KEY_PLAYER_MUTE_ON_DRAWABLE;

// Controllers themes for player
@property (nonatomic) int DEFAULT;
@property (nonatomic) int MODERN;
@property (nonatomic) int CUBE;
@property (nonatomic) int SPACE;
@property (nonatomic) int MINIMALIST;
@property (nonatomic) int ELEVATE;
@property (nonatomic) int THEATRE;

@end

#endif /* ThemeKeys_h */
