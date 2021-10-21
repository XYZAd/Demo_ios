//
//  XMIntersititialAd.h
//  XMAd
//
//  Created by C on 2020/6/29.
//  Copyright © 2020 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class XMAdModel;
@class XMAdMaterialMeta;
@protocol XMIntersititialAdDelegate;

@interface XMIntersititialAd : NSObject

- (instancetype)initWithModel:(XMAdModel *)model;

@property (nonatomic, strong, readonly) XMAdModel *adModel;

/// 是否有效
@property (nonatomic, assign, readonly) BOOL effective;

/// 插屏代理
@property (nonatomic, weak) id <XMIntersititialAdDelegate> adDelegate;

/// 广告基本信息
@property (nonatomic, strong, readonly) XMAdMaterialMeta *materialMeta;


/// 展示插屏
/// @param rootVC  根试图控制器
/// @param completion      播放结束的回调
- (BOOL)showIntersititialAdFromRootVC:(UIViewController *)rootVC
                      closeCompletion:(void (^)(void))completion;

@end

@protocol XMIntersititialAdDelegate <NSObject>
@optional
/// 曝光回调
- (void)intersititialAdDidExposure:(XMIntersititialAd *)ad;

/// 点击回调
- (void)intersititialAdDidClick:(XMIntersititialAd *)ad;

/// 关闭
- (void)intersititialAdDidClose:(XMIntersititialAd *)ad;

/// 关闭详情页回调
- (void)intersititialAdDetailPageDidClose:(XMIntersititialAd *)ad;

@end

NS_ASSUME_NONNULL_END
