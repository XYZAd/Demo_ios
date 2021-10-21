//
//  XMImgTextAdProvider.h
//  XMAd
//
//  Created by 大大东 on 2019/12/12.
//  Copyright © 2019 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMAd/XMAdProviderProtocol.h>


@class XMImgTextAd;
@class XMError;
NS_ASSUME_NONNULL_BEGIN

/// 默认只支持 gdt jrtt dsp

@interface XMImgTextAdProvider : NSObject <XMAdProviderProtocol>

/*************************1.2.5新的请求方式******************************/

/// 请求图文广告
/// @param param 请求信息
/// @param completion 回调
+ (void)imgTextAdModelWithParam:(XMAdParam *)param
                     completion:(void(^_Nonnull)(XMImgTextAd * _Nullable model, XMError *_Nullable error))completion;


/// 预加载
+ (void)preloadAds:(XMAdParam *)param;


@end

NS_ASSUME_NONNULL_END
