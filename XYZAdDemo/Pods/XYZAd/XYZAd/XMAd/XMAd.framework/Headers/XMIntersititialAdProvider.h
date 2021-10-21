//
//  XMIntersititialAdProvider.h
//  XMAd
//
//  Created by C on 2020/6/29.
//  Copyright © 2020 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMAd/XMAdProviderProtocol.h>

@class XMError,XMIntersititialAd;

NS_ASSUME_NONNULL_BEGIN

@interface XMIntersititialAdProvider : NSObject<XMAdProviderProtocol>


/// 获取intersititialAd
/// @param param 参数
/// @param completion 回调
+ (void)intersititialAdModelWithParam:(XMAdExpressParam *)param
                           completion:(void(^_Nonnull)(XMIntersititialAd * _Nullable model, XMError *_Nullable error))completion;

/// 预加载
+ (void)preloadAds:(XMAdExpressParam *)param;

@end

NS_ASSUME_NONNULL_END
