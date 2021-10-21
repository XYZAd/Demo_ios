//
//  XMSplashAdProvider.h
//  XMAd
//
//  Created by 大大东 on 2020/3/19.
//  Copyright © 2020 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMError;

NS_ASSUME_NONNULL_BEGIN

@protocol XMSplashAdDelegate;

@interface XMSplashAdProvider : NSObject

/// 非全屏开屏广告底部填充试图
@property (nonatomic, strong, nullable) UIView *customSplashBottomView;

/// 开屏代理
@property (nonatomic, weak) id <XMSplashAdDelegate> adDelegate;

/// 广告基本信息
@property (nonatomic, strong, readonly) XMAdMaterialMeta *materialMeta;

/// 请求开屏广告 （立即展示假的启动图<依次取LaunchStoryboard、LaunchImage>）
/// @param param 广告位 （不可更改，如果广告位不同，请实例化多个本类对象）
/// @param size size (一般为 宽等于屏幕宽 高为屏幕高*0.84, 不能低于屏幕的75%)
/// @param time 最大等待时长（会限制在 2 - 8s）
/// @param completion 回调
- (void)adWithParam:(nonnull XMAdParam *)param
             adsize:(CGSize)size
          totalTime:(CGFloat)time
         completion:(void(^_Nonnull)(BOOL success, XMError *_Nullable error))completion;


/// 展示 (请在广告请求成功后 调用， 否则无效)
- (void)presentWithCloseHandle:(void(^)(void))closeCallback;

/// 取消当前广告加载
- (void)cancel;

/// 广告云控是否有效
- (BOOL)adClouldValidWithPosition:(nullable XMAdPageType *)position;


@end


@protocol XMSplashAdDelegate <NSObject>
@optional
/// 曝光回调
- (void)splashAdDidExposure:(XMSplashAdProvider *)provider;

/// 点击回调
- (void)splashAdDidClick:(XMSplashAdProvider *)provider;

/// 关闭
- (void)splashAdDidClose:(XMSplashAdProvider *)provider;

/// 关闭详情页回调
- (void)splashAdDetailPageDidClose:(XMSplashAdProvider *)provider;

/// 开屏失败
- (void)splashAdPresent:(XMSplashAdProvider *)provider error:(XMError *)error;

@end

NS_ASSUME_NONNULL_END
