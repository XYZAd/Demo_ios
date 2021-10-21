//
//  XMVideoAdProvider.h
//  XMAd
//
//  Created by 大大东 on 2019/12/12.
//  Copyright © 2019 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMAd/XMAdProviderProtocol.h>

@class XMVideoAd;

NS_ASSUME_NONNULL_BEGIN


@interface XMVideoAdProvider : NSObject <XMAdProviderProtocol>


/// 获取激励视频广告
/// @param param 参数
/// @param completion 回调
+ (void)videoAdModelWithParam:(XMAdParam *)param
                   completion:(void(^_Nonnull)(XMVideoAd * _Nullable model, XMError *_Nullable error))completion;

/// 预加载
+ (void)preloadAds:(XMAdParam *)param;
@end

NS_ASSUME_NONNULL_END
