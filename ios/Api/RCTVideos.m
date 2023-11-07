#import "RCTVideos.h"
#import <Foundation/Foundation.h>
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import <React/RCTLog.h>
#import "ZiggeoConstants.h"


@interface VideosContext: NSObject

@property (strong, nonatomic) RCTPromiseResolveBlock resolveBlock;
@property (strong, nonatomic) RCTPromiseRejectBlock rejectBlock;
@property (strong, nonatomic) RCTVideos* videos;

@end;


@implementation VideosContext

- (void)resolve:(NSString *)token {
    if (_resolveBlock) {
        _resolveBlock(token);
    }
    _resolveBlock = nil;
    _rejectBlock = nil;
    self.videos = nil;
}

- (void)reject:(NSString *)code
       message:(NSString *)message {
    if (_rejectBlock) {
        _rejectBlock(code, message, [NSError errorWithDomain:@"videos" code:0 userInfo:@{code:message}]);
    }
    _resolveBlock = nil;
    _rejectBlock = nil;
    self.videos = nil;
}

@end;


@implementation RCTVideos

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
    [[[ZiggeoConstants shared] videos] index:map
                                    callback:^(NSArray *jsonArray, NSError *error) {
        if (error == NULL) {
            resolve(jsonArray);
        } else {
            reject(@"ERR_VIDEOS", @"video index error", error);
        }
    }];
}

RCT_EXPORT_METHOD(destroy:(NSString *)tokenOrKey
                  streamToken:(NSString *)streamToken
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[[ZiggeoConstants shared] videos] destroy:tokenOrKey
                                   streamToken:streamToken
                                      callback:^(NSDictionary *jsonObject, NSURLResponse *response, NSError *error) {
        if (error == NULL) {
            resolve(jsonObject);
        } else {
            reject(@"ERR_VIDEOS", @"video destroy error", error);
        }
    }];
}

RCT_EXPORT_METHOD(get:(NSString *)tokenOrKey
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[[ZiggeoConstants shared] videos] get:tokenOrKey
                                      data:NULL
                                  callback:^(ContentModel *content, NSURLResponse *response, NSError *error) {
        resolve(content);
    }];
}

RCT_EXPORT_METHOD(create:(NSString *)file
                  map:(NSDictionary *)map
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[[ZiggeoConstants shared] videos] create:file
                                         data:map
                                     callback:^(NSDictionary *jsonObject, NSURLResponse *response, NSError *error) {
        if (error != NULL) {
            reject(@"ERR_VIDEOS", @"video create error", error);
        }
    } progress:^(int totalBytesSent, int totalBytesExpectedToSend) {
    } confirmCallback:^(NSDictionary *jsonObject, NSURLResponse *response, NSError *error) {
        if (error == NULL) {
            resolve(jsonObject);
        } else {
            reject(@"ERR_VIDEOS", @"video create error", error);
        }
    }];
}

RCT_EXPORT_METHOD(update:(NSString *)token
                  map:(NSDictionary *)map
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[[ZiggeoConstants shared] videos] update:token
                                         data:map
                                     callback:^(ContentModel *content, NSURLResponse *response, NSError *error) {
        if (error == NULL) {
            resolve(content);
        } else {
            reject(@"ERR_VIDEOS", @"video update error", error);
        }
    }];
}

RCT_EXPORT_METHOD(getImageUrl:(NSString *)tokenOrKey
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    resolve([[[ZiggeoConstants shared] videos] getImageUrl:tokenOrKey]);
}

RCT_EXPORT_METHOD(getVideoUrl:(NSString *)tokenOrKey
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) return;
    resolve([[[ZiggeoConstants shared] videos] getVideoUrl:tokenOrKey]);
}

@end
