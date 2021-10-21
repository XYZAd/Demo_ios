//
//  XMVideoAd.h
//  XMAd
//
//  Created by 大大东 on 2019/12/26.
//  Copyright © 2019 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMAd/XMVideoExtraProtocol.h>


@class XMAdModel;
@class XMAdMaterialMeta;
@class XMError;
NS_ASSUME_NONNULL_BEGIN

@protocol XMVideoAdDelegate;

@interface XMVideoAd : NSObject <XMVideoExtraDelegate>

- (instancetype)initWithModel:(XMAdModel *)model;

@property (nonatomic, strong, readonly) XMAdModel *adModel;

/// 是否有效
@property (nonatomic, assign, readonly) BOOL effective;

/// 播放代理
@property (nonatomic, weak) id <XMVideoAdDelegate> adDelegate;

/// 是否静音播放
@property (nonatomic, assign) BOOL videoMuted;

/// 广告基本信息
@property (nonatomic, strong, readonly) XMAdMaterialMeta *materialMeta;
/// 播放激励视频
/// @param viewController  使用这个vc进行模态
/// @param completion      播放结束的回调, 如果errmsg存在，可以toust提示
- (BOOL)playAdFromVC:(UIViewController *)viewController playCompletion:(void (^)(BOOL success, NSString * _Nullable errMsg))completion;

@end

@protocol XMVideoAdDelegate <NSObject>
@optional
/// 曝光回调
- (void)videoAdDidExposure:(XMVideoAd *)ad;

/// 点击回调
- (void)videoAdDidClick:(XMVideoAd *)ad;

/// 关闭
- (void)videoAdDidClose:(XMVideoAd *)ad;

/// 视频播放结束回调
- (void)videoAdPlayFinished:(BOOL)finished error:(XMError *)error;

/// 视频上方自定义额外的试图，例如vip充值可跳过广告(慎用)
/// @param ad ad
- (UIView *)videoAdCustomExtraView:(XMVideoAd *)ad;

/// 自定义试图是否常驻激励视频（无论是播放时，还是播放结束），默认false
- (BOOL)videoAdCustomExtraViewAlwaysOnContainer:(XMVideoAd *)ad;

/// 额外的视频被点击
- (void)videoAdExtraViewDidClick:(XMVideoAd *)ad controller:(UIViewController *)vc;

@end


NS_ASSUME_NONNULL_END
