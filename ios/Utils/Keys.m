#import "Keys.h"

@implementation Keys

static Keys *m_keys = NULL;

+ (Keys *)shared {
    @synchronized(self) {
        if (m_keys == NULL) {
            m_keys = [[Keys alloc] init];
        }
    }
    return m_keys;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.BYTES_SENT = @"bytesSent";
        self.BYTES_TOTAL = @"totalBytes";
        self.FILE_NAME = @"fileName";
        self.PATH = @"path";
        self.TYPE = @"type";
        self.QR = @"qr";
        self.TOKEN = @"token";
        self.STREAM_TOKEN = @"stream_token";
        self.PERMISSIONS = @"permissions";
        self.SOUND_LEVEL = @"sound_level";
        self.SECONDS_LEFT = @"seconds_left";
        self.MILLIS_PASSED = @"millis_passed";
        self.MILLIS = @"millis";
        self.FILES = @"files";
        self.VALUE = @"value";
        self.CLOSE_AFTER_SUCCESSFUL_SCAN = @"closeAfterSuccessfulScan";
    }
    return self;
}

@end
