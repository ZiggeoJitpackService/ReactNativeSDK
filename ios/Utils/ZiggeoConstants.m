#import "ZiggeoConstants.h"
#import "ZiggeoRecorderContext.h"


@implementation ZiggeoConstants

static Ziggeo *m_ziggeo = NULL;
static NSString *m_appToken = NULL;
static ZiggeoRecorderContext *m_context = NULL;

+ (void)setAppToken:(NSString *)appToken {
    m_appToken = appToken;
    
    @synchronized(self) {
        if (m_ziggeo == NULL) {
            m_ziggeo = [[Ziggeo alloc] initWithToken:m_appToken];
        }
    }
}

+ (ZiggeoRecorderContext *)sharedContext {
    @synchronized(self) {
        if (m_context == NULL) {
            m_context = [[ZiggeoRecorderContext alloc] init];
        }
    }
    return m_context;
}

+ (Ziggeo *)shared {
    return m_ziggeo;
}


@end
