//
//  XMFullScreenAd.h
//  XMAd
//
//  Created by C on 2021/8/16.
//  Copyright © 2021 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class XMAdModel;
@class XMAdMaterialMeta;
@protocol XMFullScreenAdDelegate;

@interface XMFullScreenAd : NSObject

- (instancetype)initWithModel:(XMAdModel *)model;

@property (nonatomic, strong, readonly) XMAdModel *adModel;

/// 是否有效
@property (nonatomic, assign, readonly) BOOL effective;

/// 代理
@property (nonatomic, weak) id <XMFullScreenAdDelegate> adDelegate;

/// 广告基本信息
@property (nonatomic, strong, readonly) XMAdMaterialMeta *materialMeta;


/// 展示全屏广告
/// @param rootVC  根试图控制器
/// @param completion      播放结束的回调
- (BOOL)showFullScreenAdFromRootVC:(UIViewController *)rootVC
                   closeCompletion:(void (^)(BOOL success, NSString * _Nullable errMsg))completion;

@end

@protocol XMFullScreenAdDelegate <NSObject>
@optional
/// 曝光回调
- (void)fullScreenAdDidExposure:(XMFullScreenAd *)ad;

/// 点击回调
- (void)fullScreenAdDidClick:(XMFullScreenAd *)ad;

/// 关闭
- (void)fullScreenAdDidClose:(XMFullScreenAd *)ad;

/// 关闭详情页回调
- (void)fullScreenAdDetailPageDidClose:(XMFullScreenAd *)ad;

@end
NS_ASSUME_NONNULL_END
