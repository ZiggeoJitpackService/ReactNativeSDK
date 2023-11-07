#import "RCTContactUs.h"
#import <Foundation/Foundation.h>
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import <React/RCTLog.h>
#import "ZiggeoConstants.h"

@implementation RCTContactUs {
    
}

static NSString *_appToken;
static NSString *_serverAuthToken;
static NSString *_clientAuthToken;

+ (NSString *)appToken {
    return _appToken;
}

+ (NSString *)serverAuthToken {
    return _serverAuthToken;
}

+ (NSString *)clientAuthToken {
    return _clientAuthToken;
}


RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
    return @[
    ];
}

RCT_EXPORT_METHOD(setAppToken:(NSString *)token)
{
    RCTLogInfo(@"application token set: %@", token);
    _appToken = token;
    [ZiggeoConstants setAppToken:token];
}

RCT_EXPORT_METHOD(setServerAuthToken:(NSString *)token)
{
    RCTLogInfo(@"server auth token set: %@", token);
    _serverAuthToken = token;
    [[ZiggeoConstants shared].connect setServerAuthToken:token];
}

RCT_EXPORT_METHOD(setClientAuthToken:(NSString *)token)
{
    RCTLogInfo(@"server auth token set: %@", token);
    _clientAuthToken = token;
    [[ZiggeoConstants shared].connect setClientAuthToken:token];
}


RCT_EXPORT_METHOD(sendReport:(NSArray *)logsList)
{
    RCTLogInfo(@"sendReport: %@", logsList);
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared] sendReport:logsList];
}

RCT_EXPORT_METHOD(sendEmailToSupport)
{
    RCTLogInfo(@"sendEmailToSupport");
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared] sendEmailToSupport];
}

@end

