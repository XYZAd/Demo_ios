//
//  XMExpressDrawAdProvider.h
//  XMAd
//
//  Created by C on 2020/9/8.
//  Copyright © 2020 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMAd/XMAdProviderProtocol.h>
@class XMExpressDrawAd;
NS_ASSUME_NONNULL_BEGIN

@interface XMExpressDrawAdProvider : NSObject<XMAdProviderProtocol>



/// 获取模版draw
/// @param param 参数
/// @param completion 回调
+ (void)expressDrawVideoAdWithParam:(XMAdExpressParam *)param
                         completion:(void(^_Nonnull)(XMExpressDrawAd * _Nullable model, XMError * _Nullable error))completion;

/// 预加载
+ (void)preloadAds:(XMAdExpressParam *)param;

@end

NS_ASSUME_NONNULL_END
