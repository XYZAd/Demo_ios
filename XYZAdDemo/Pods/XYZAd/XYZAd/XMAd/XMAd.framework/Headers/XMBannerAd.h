//
//  XMBannerAd.h
//  XMAd
//
//  Created by 大大东 on 2019/12/26.
//  Copyright © 2019 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>


@class XMAdModel;
@class XMAdMaterialMeta;
@protocol XMBannerAdDelegate;
NS_ASSUME_NONNULL_BEGIN

@interface XMBannerAd : NSObject

- (instancetype)initWithModel:(XMAdModel *)model;

/// 是否有效
@property (nonatomic, assign, readonly) BOOL effective;

/// sdk BannerView有关闭按钮，此为关闭后的回调，可以做一些容器的移除操作
@property (nonatomic, copy) void(^bannerDidCloseCallback)(void) DEPRECATED_MSG_ATTRIBUTE("please use delegate");

/// banner代理
@property (nonatomic, weak) id <XMBannerAdDelegate> adDelegate;

/// 广告基本信息
@property (nonatomic, strong, readonly) XMAdMaterialMeta *materialMeta;

/// 用来跳转的vc，可不传
@property (nonatomic, weak, nullable) UIViewController *presenterController;

/// 获取bannerView 添加约束 内容已显示在此view上
- (UIView *)adBannerView;

@end

@protocol XMBannerAdDelegate <NSObject>
@optional
/// 曝光回调
- (void)bannerAdDidExposure:(XMBannerAd *)ad;

/// 点击回调
- (void)bannerAdDidClick:(XMBannerAd *)ad;

/// 关闭
- (void)bannerAdDidClose:(XMBannerAd *)ad;

/// 关闭详情页回调
- (void)bannerAdDetailPageDidClose:(XMBannerAd *)ad;

@end

NS_ASSUME_NONNULL_END
