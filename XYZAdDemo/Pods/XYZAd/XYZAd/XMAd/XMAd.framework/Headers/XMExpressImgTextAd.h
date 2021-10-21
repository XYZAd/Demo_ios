//
//  XMExpressImgTextAd.h
//  XMAd
//
//  Created by C on 2021/8/2.
//  Copyright © 2021 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class XMAdModel;
@protocol XMExpressImgTextAdDelegate;

@interface XMExpressImgTextAd : NSObject


@property (nonatomic, weak) id <XMExpressImgTextAdDelegate> delegate;

- (instancetype)initWithModel:(XMAdModel *)model;


/// 获取模版view
- (UIView *)expressView;

/// 渲染
- (void)render;

/// 移除渲染
- (void)unRender;

@end

@protocol XMExpressImgTextAdDelegate <NSObject>

/// 曝光回调
- (void)expressImgTextAdDidExposure:(XMExpressImgTextAd *)ad;

/// 点击回调
- (void)expressImgTextAdDidClick:(XMExpressImgTextAd *)ad;

/// 用来跳转的vc
- (UIViewController *)expressImgTextAdPresentViewController;

@end

NS_ASSUME_NONNULL_END
