#import "ThemeKeys.h"

@implementation ThemeKeys

static ThemeKeys *m_themeKeys = NULL;

+ (ThemeKeys *)shared {
    @synchronized(self) {
        if (m_themeKeys == NULL) {
            m_themeKeys = [[ThemeKeys alloc] init];
        }
    }
    return m_themeKeys;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.KEY_HIDE_RECORDER_CONTROLS = @"hideRecorderControls";
        self.KEY_HIDE_PLAYER_CONTROLS = @"hidePlayerControls";
        self.KEY_PLAYER_CONTROLLER_STYLE = @"controllerStyle";
        self.KEY_PLAYER_TEXT_COLOR = @"textColor";
        self.KEY_PLAYER_UNPLAYED_COLOR = @"unplayedColor";
        self.KEY_PLAYER_PLAYED_COLOR = @"playedColor";
        self.KEY_PLAYER_BUFFERED_COLOR = @"bufferedColor";
        self.KEY_PLAYER_TINT_COLOR = @"tintColor";
        self.KEY_PLAYER_MUTE_OFF_DRAWABLE = @"muteOffImageDrawable";
        self.KEY_PLAYER_MUTE_ON_DRAWABLE = @"muteOnImageDrawable";

        // Controllers themes for player
        self.DEFAULT = 0;
        self.MODERN = 1;
        self.CUBE = 2;
        self.SPACE = 3;
        self.MINIMALIST = 4;
        self.ELEVATE = 5;
        self.THEATRE = 6;
    }
    return self;
}

@end
