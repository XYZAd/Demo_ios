//
//  XMFullScreenAdProvider.h
//  XMAd
//
//  Created by C on 2021/8/16.
//  Copyright © 2021 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMAd/XMAdProviderProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@class XMFullScreenAd;

@interface XMFullScreenAdProvider : NSObject <XMAdProviderProtocol>

/// 获取模版draw
/// @param param 参数
/// @param completion 回调
+ (void)fullScreenAdWithParam:(XMAdParam *)param
                   completion:(void(^_Nonnull)(XMFullScreenAd * _Nullable model, XMError * _Nullable error))completion;

/// 预加载
+ (void)preloadAds:(XMAdParam *)param;

@end

NS_ASSUME_NONNULL_END
