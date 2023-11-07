#import "RecorderKeys.h"

@implementation RecorderKeys

static RecorderKeys *m_recorderKeys = NULL;

+ (RecorderKeys *)shared {
    @synchronized(self) {
        if (m_recorderKeys == NULL) {
            m_recorderKeys = [[RecorderKeys alloc] init];
        }
    }
    return m_recorderKeys;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.KEY_CACHE_SIZE = @"cache_size";
        self.KEY_CACHE_ROOT = @"cache_root";

        self.KEY_TITLE_RES_ID = @"title_res_id";
        self.KEY_TITLE_TEXT = @"title_text";
        self.KEY_MESSAGE_RES_ID = @"mes_res_id";
        self.KEY_MESSAGE_TEXT = @"mes_text";
        self.KEY_POSITIVE_BUTTON_RES_ID = @"pos_btn_res_id";
        self.KEY_POSITIVE_BUTTON_TEXT = @"pos_btn_text";
        self.KEY_NEGATIVE_BUTTON_RES_ID = @"neg_btn_res_id";
        self.KEY_NEGATIVE_BUTTON_TEXT = @"neg_btn_text";

        self.KEY_USE_WIFI_ONLY = @"use_wifi_only";
        self.KEY_SYNC_INTERVAL = @"sync_interval";
        self.KEY_TURN_OFF_UPLOADER = @"turn_off_uploader";
        self.KEY_START_AS_FOREGROUND = @"start_as_foreground";
        self.KEY_LOST_CONNECTION_ACTION = @"lost_connection_action";
    }
    return self;
}

@end
