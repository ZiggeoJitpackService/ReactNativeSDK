//
//  RCTZiggeoPlayer.m
//  ReactIntegrationDemo
//
//  Copyright © 2017 Ziggeo. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVKit;
#import "RCTZiggeoPlayer.h"
#import <ZiggeoMediaSDK/ZiggeoMediaSDK.h>
#import <React/RCTLog.h>
#import "ZiggeoRecorderContext.h"
#import "ZiggeoConstants.h"
#import "ThemeKeys.h"
#import "Events.h"

@implementation RCTZiggeoPlayer {
    UIViewController *_adController;
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(setAppToken:(NSString *)token)
{
    RCTLogInfo(@"application token set: %@", token);
    _appToken = token;
    [ZiggeoConstants setAppToken:_appToken];
}

RCT_EXPORT_METHOD(setServerAuthToken:(NSString *)token)
{
  RCTLogInfo(@"server auth token set: %@", token);
  _serverAuthToken = token;
}

RCT_EXPORT_METHOD(setClientAuthToken:(NSString *)token)
{
  RCTLogInfo(@"client auth token set: %@", token);
  _clientAuthToken = token;
}


RCT_EXPORT_METHOD(playVideo:(NSArray *)videoTokens)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared] playVideos:videoTokens];
}

RCT_EXPORT_METHOD(playVideos:(NSArray *)videoTokens)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared] playVideos:videoTokens];
}

RCT_EXPORT_METHOD(playFromUri:(NSArray *)urls)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared] playFromUris:urls];
}

RCT_EXPORT_METHOD(playFromUris:(NSArray *)urls)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared] playFromUris:urls];
}

RCT_EXPORT_METHOD(setExtraArgsForPlayer:(NSDictionary *)map)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].playerConfig setExtraArgs:map];
}

RCT_EXPORT_METHOD(setThemeArgsForPlayer:(NSDictionary *)map)
{
    if ([ZiggeoConstants shared] == nil) return;
    if ([map.allKeys containsObject:ThemeKeys.shared.KEY_HIDE_PLAYER_CONTROLS]) {
        BOOL hideControls = [map[ThemeKeys.shared.KEY_HIDE_PLAYER_CONTROLS] boolValue];
        [[ZiggeoConstants shared].playerConfig.style setHideControls:hideControls];
    }
}

RCT_EXPORT_METHOD(setAdsURL:(NSString *)url)
{
    if ([ZiggeoConstants shared] == nil) return;
    [[ZiggeoConstants shared].playerConfig setAdsUri:url];
}

// MARK: - Get functions
RCT_REMAP_METHOD(getAppToken,
                 resolver1:(RCTPromiseResolveBlock)resolve
                 rejecter1:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([[ZiggeoConstants shared] getAppToken]);
}

RCT_REMAP_METHOD(getClientAuthToken,
                 resolver2:(RCTPromiseResolveBlock)resolve
                 rejecter2:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([[ZiggeoConstants shared] getClientAuthToken]);
}

RCT_REMAP_METHOD(getServerAuthToken,
                 resolver3:(RCTPromiseResolveBlock)resolve
                 rejecter3:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([[ZiggeoConstants shared] getServerAuthToken]);
}

RCT_REMAP_METHOD(getAdsURL,
                 resolver4:(RCTPromiseResolveBlock)resolve
                 rejecter4:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([[ZiggeoConstants shared].playerConfig getAdsUri]);
}

RCT_REMAP_METHOD(getThemeArgsForPlayer,
                 resolver5:(RCTPromiseResolveBlock)resolve
                 rejecter5:(RCTPromiseRejectBlock)reject)
{
    if ([ZiggeoConstants shared] == nil) reject(Events.shared.ERROR, @"Ziggeo is not initialized.", NULL);
    else resolve([[ZiggeoConstants shared].playerConfig getExtraArgs]);
}


@end
