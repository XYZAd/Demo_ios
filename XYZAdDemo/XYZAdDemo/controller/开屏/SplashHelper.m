//
//  SplashHelper.m
//  Demo
//
//  Created by C on 2022/2/24.
//  Copyright © 2022 大大东. All rights reserved.
//

#import "SplashHelper.h"

@interface SplashHelper() <XMSplashAdDelegate>



@end

@implementation SplashHelper

+ (instancetype)sharedInstance {
    static SplashHelper *defaultHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultHelper = [[self alloc] init];
    });
    return defaultHelper;
}

- (instancetype)init {
    if (self = [super init]) {
        _splashProvider = [[XMSplashAdProvider alloc] init];
        _splashProvider.adDelegate = self;
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.yellowColor;
        _splashProvider.customSplashBottomView = view;
    }
    return self;
}

- (void)loadSplashWithSize:(CGSize)size {
    XMAdParam *param = [XMAdParam new];
    param.position = kDemoSplash;
    [_splashProvider loadSplashAdWithParam:param adsize:size totalTime:5];
}

- (void)splashAdDidLoad:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,加载成功",__func__]];
    [_splashProvider showSplashAd];
}

- (void)splashAdPresent:(XMSplashAdProvider *)provider error:(XMError *)error {
    NSLog(@"------%s--",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,失败",__func__]];
}

/// 曝光回调
- (void)splashAdDidExposure:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

/// 点击回调
- (void)splashAdDidClick:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

- (void)splashAdWillClose:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,即将关闭",__func__]];
}


/// 关闭
- (void)splashAdDidClose:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,关闭",__func__]];
}

/// 关闭详情页回调
- (void)splashAdDetailPageDidClose:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,详情页关闭",__func__]];
}


@end
