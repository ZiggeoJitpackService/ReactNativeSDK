#import "FileSelectorKeys.h"

@implementation FileSelectorKeys

static FileSelectorKeys *m_fileSelectorKeys = NULL;

+ (FileSelectorKeys *)shared {
    @synchronized(self) {
        if (m_fileSelectorKeys == NULL) {
            m_fileSelectorKeys = [[FileSelectorKeys alloc] init];
        }
    }
    return m_fileSelectorKeys;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.KEY_MAX_DURATION = @"maxDuration";
        self.KEY_MIN_DURATION = @"minDuration";
        self.KEY_ALLOW_MULTIPLE_SELECTION = @"shouldAllowMultipleSelection";
        self.KEY_MEDIA_TYPE = @"mediaType";
        self.KEY_EXTRA_ARGS = @"extraArgs";
    }
    return self;
}

@end
