//
//  UniversalShowViewController.m
//  Demo
//
//  Created by C on 2022/2/24.
//  Copyright © 2022 大大东. All rights reserved.
//

#import "UniversalShowViewController.h"
#import "UniversalTextAdView.h"
#import "UniversalDrawAdView.h"

@interface UniversalShowViewController () <XMImgTextAdDelegate,XMBannerAdDelegate>

@property (nonatomic, strong) XMUniversalAd *universalAd;

@end

@implementation UniversalShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_universalAd.positionAdType == XMAdPositionAdTypeFeed ||
        _universalAd.positionAdType == XMAdPositionAdTypePaster) {
        UniversalTextAdView *textAdView = [[UniversalTextAdView alloc] initWithTextAd:self.universalAd.imgTextAd container:self];
        self.universalAd.imgTextAd.adDelegate = self;
        [self.view addSubview:textAdView];
        [textAdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@100);
            make.centerX.equalTo(@0);
        }];
    } else if (_universalAd.positionAdType == XMAdPositionAdTypeDraw) {
        UniversalDrawAdView *drawAdView = [[UniversalDrawAdView alloc] initWithTextAd:self.universalAd.imgTextAd container:self];
        self.universalAd.imgTextAd.adDelegate = self;
        [self.view addSubview:drawAdView];
        [drawAdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(demo_isBangScreen() ? 88 : 64));
            make.left.right.bottom.equalTo(@0);
        }];
    } else if (_universalAd.positionAdType == XMAdPositionAdTypeExpressBanner) {
        XMBannerAd *bannerAd = self.universalAd.bannerAd;
        bannerAd.adDelegate = self;
        [self.view addSubview:bannerAd.adBannerView];
        [bannerAd.adBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(bannerAd.adBannerView.frame.size);
            make.center.equalTo(@0);
        }];
        
    }
    
    
}

#pragma mark --imgTextAd
- (void)imgTextShowFailed:(XMImgTextAd *)ad error:(XMError *)error {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,渲染失败",__func__]];
}

- (void)imgTextAdDidExposure:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

- (void)imgTextAdDidClick:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

- (void)imgTextAdDetailPageDidClose:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,详情页关闭",__func__]];
}

/// 关闭广告（模版广告才走这个代理）
- (void)imgTextAdDidClose:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,广告关闭",__func__]];
}

/// 视频加载，如果失败，可以调用refreshAdData，重新刷新
- (void)imgTextAdMediaLoadFinish:(XMImgTextAd *)ad error:(XMError *)error {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,视频加载",__func__]];
}

/// 视频播放状态
- (void)imgTextAdMediaPlaying:(XMImgTextAd *)ad playerStatusChanged:(XMAdMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,视频播放状态",__func__]];
}

#pragma mark ---Banner

- (void)bannerAdDidClick:(XMBannerAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

- (void)bannerAdDetailPageDidClose:(XMBannerAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,详情页关闭",__func__]];
}

- (void)bannerAdDidExposure:(XMBannerAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

- (void)bannerAdDidClose:(XMBannerAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,关闭",__func__]];
}

+ (void)showTextAd:(XMUniversalAd *)universalAd {
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UniversalShowViewController *vc = [UniversalShowViewController new];
    [nav pushViewController:vc animated:YES];
    
}


@end
