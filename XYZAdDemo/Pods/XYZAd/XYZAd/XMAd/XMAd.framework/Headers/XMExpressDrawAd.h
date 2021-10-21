//
//  XMExpressDrawAd.h
//  XMAd
//
//  Created by C on 2020/9/8.
//  Copyright © 2020 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>
  
@class XMAdModel;

@protocol XMExpressDrawAdDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface XMExpressDrawAd : NSObject

- (instancetype)initWithModel:(XMAdModel *)model;

@property (nonatomic, strong, readonly) XMAdModel *adModel;

/// 是否有效
@property (nonatomic, assign, readonly) BOOL effective;

/// 委托
@property (nonatomic, weak) id <XMExpressDrawAdDelegate> adDelegate;

/// 广告基本信息
@property (nonatomic, strong, readonly) XMAdMaterialMeta *materialMeta;

/*
 required.
 Root view controller for handling ad actions.
 */
@property (nonatomic, weak) UIViewController * rootViewController;

/// 广告试图
@property (nonatomic, strong, readonly) UIView *drawView;

- (void)render;

- (void)unRender;

@end

@protocol XMExpressDrawAdDelegate <NSObject>

@optional
/// 是否渲染完成，error为nil是渲染完成
- (void)expressDrawAdRender:(XMExpressDrawAd *)ad error:(XMError *)error;

/// 曝光回调
- (void)expressDrawAdDidExposure:(XMExpressDrawAd *)ad;

/// 点击回调
- (void)expressDrawAdDidClick:(XMExpressDrawAd *)ad;

/// 播放完成
- (void)expressDrawAdPlayFinished:(XMExpressDrawAd *)ad error:(XMError *)error;

/// 视频播放状态
- (void)expressDrawAdMediaPlaying:(XMExpressDrawAd *)ad playerStatusChanged:(XMAdMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo;

/// 关闭详情页回调
- (void)expressDrawAdDetailPageDidClose:(XMExpressDrawAd *)ad;

@end

NS_ASSUME_NONNULL_END
