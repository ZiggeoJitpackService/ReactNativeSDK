#import "RCTAudios.h"
#import <Foundation/Foundation.h>
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import <React/RCTLog.h>
#import "ZiggeoConstants.h"


@interface AudiosContext: NSObject

@property (strong, nonatomic) RCTPromiseResolveBlock resolveBlock;
@property (strong, nonatomic) RCTPromiseRejectBlock rejectBlock;
@property (strong, nonatomic) RCTAudios* audios;

@end;


@implementation AudiosContext

- (void)resolve:(NSString *)token {
    if (_resolveBlock) {
        _resolveBlock(token);
    }
    _resolveBlock = nil;
    _rejectBlock = nil;
    self.audios = nil;
}

- (void)reject:(NSString *)code
       message:(NSString *)message {
    if (_rejectBlock) {
        _rejectBlock(code, message, [NSError errorWithDomain:@"audios" code:0 userInfo:@{code:message}]);
    }
    _resolveBlock = nil;
    _rejectBlock = nil;
    self.audios = nil;
}

@end;


@implementation RCTAudios

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


RCT_EXPORT_METHOD(index:(NSDictionary *)map
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[[ZiggeoConstants shared] audios] index:map
                              stringCallback:^(NSString *string, NSURLResponse *response, NSError *error) {
        if (error == NULL) {
            resolve(string);
        } else {
            reject(@"ERR_AUDIOS", @"audio index error", error);
        }
    }];
}

RCT_EXPORT_METHOD(destroy:(NSString *)tokenOrKey
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[[ZiggeoConstants shared] audios] destroy:tokenOrKey
                                      callback:^(NSDictionary *jsonObject, NSURLResponse *response, NSError *error) {
        if (error == NULL) {
            resolve(jsonObject);
        } else {
            reject(@"ERR_AUDIOS", @"audio destroy error", error);
        }
    }];
}

RCT_EXPORT_METHOD(get:(NSString *)tokenOrKey
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[[ZiggeoConstants shared] audios] get:tokenOrKey
                                      data:NULL
                                  callback:^(Audio *content, NSURLResponse *response, NSError *error) {
        resolve(content);
    }];
}

RCT_EXPORT_METHOD(create:(NSString *)file
                  map:(NSDictionary *)map
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[[ZiggeoConstants shared] audios] create:file
                                         data:map
                                     callback:^(NSDictionary *jsonObject, NSURLResponse *response, NSError *error) {
        if (error != NULL) {
            reject(@"ERR_AUDIOS", @"audio create error", error);
        }
    } progress:^(int totalBytesSent, int totalBytesExpectedToSend) {
    } confirmCallback:^(NSDictionary *jsonObject, NSURLResponse *response, NSError *error) {
        if (error == NULL) {
            resolve(jsonObject);
        } else {
            reject(@"ERR_AUDIOS", @"audio create error", error);
        }
    }];
}

RCT_EXPORT_METHOD(update:(NSString *)token
                  map:(NSDictionary *)map
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[[ZiggeoConstants shared] audios] update:token
                                         data:map
                                     callback:^(Audio *content, NSURLResponse *response, NSError *error) {
        if (error == NULL) {
            resolve(content);
        } else {
            reject(@"ERR_AUDIOS", @"audio update error", error);
        }
    }];
}

RCT_EXPORT_METHOD(source:(NSString *)tokenOrKey
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    resolve([[[ZiggeoConstants shared] audios] getAudioUrl:tokenOrKey]);
}

RCT_EXPORT_METHOD(getAudioUrl:(NSString *)tokenOrKey
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    resolve([[[ZiggeoConstants shared] audios] getAudioUrl:tokenOrKey]);
}

@end
