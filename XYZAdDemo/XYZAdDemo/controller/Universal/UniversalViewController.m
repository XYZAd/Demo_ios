//
//  UniversalViewController.m
//  Demo
//
//  Created by C on 2022/2/24.
//  Copyright © 2022 大大东. All rights reserved.
//

#import "UniversalViewController.h"
#import "UniversalShowViewController.h"
#import "SplashHelper.h"
#import "XMNativeIntersititialAdViewController.h"

@interface UniversalViewController () <XMVideoAdDelegate,XMFullScreenAdDelegate,XMIntersititialAdDelegate>
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) XMUniversalAd *universalAd;

@end

@implementation UniversalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageLabel.text = @"请拉取广告";
}

- (XMAdUniversalParam *)createUniversalParam {
    XMAdUniversalParam *param = [XMAdUniversalParam new];
    param.gametypeID = @"aaaaa";
    NSMutableArray *array = [NSMutableArray new];
    
    XMAdUniversalSubParam *splashSubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoSplash adPositionAdType:XMAdPositionAdTypeSplash];
    [array addObject:splashSubParam];
    
    XMAdUniversalSubParam *feedSubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoImgText adPositionAdType:XMAdPositionAdTypeFeed];
    feedSubParam.expectAdSize = CGSizeMake(1280, 720);
    [array addObject:feedSubParam];
    
    XMAdUniversalSubParam *pasterSubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoPaster adPositionAdType:XMAdPositionAdTypePaster];
    pasterSubParam.expectAdSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width * 2, 200 * 2);
    [array addObject:pasterSubParam];
    
    XMAdUniversalSubParam *drawSubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoDraw adPositionAdType:XMAdPositionAdTypeDraw];
    drawSubParam.expectAdSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds) * 2, (CGRectGetHeight(UIScreen.mainScreen.bounds) - 64 - (demo_isBangScreen() ? 24 : 0) * 2));
    [array addObject:drawSubParam];
    
    
    XMAdUniversalSubParam *nativeIntersititialSubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoNativeInitial adPositionAdType:XMAdPositionAdTypeNativeInterstitial];
    nativeIntersititialSubParam.expectAdSize = CGSizeMake(1080, 1920);
    [array addObject:nativeIntersititialSubParam];
    
    
    XMAdUniversalSubParam *expressBannerSubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoBanner adPositionAdType:XMAdPositionAdTypeExpressBanner];
    expressBannerSubParam.expectAdSize = CGSizeMake(600, 160);
    [array addObject:expressBannerSubParam];
    
    XMAdUniversalSubParam *videoSubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoRewardVideo adPositionAdType:XMAdPositionAdTypeRewardVideo];
    [array addObject:videoSubParam];
    
    XMAdUniversalSubParam *intersititialSubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoInitial adPositionAdType:XMAdPositionAdTypeIntersititial];
    intersititialSubParam.expectAdSize = CGSizeMake(600, 900);
    [array addObject:intersititialSubParam];
    
    XMAdUniversalSubParam *intersititialV2SubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoNewInitial adPositionAdType:XMAdPositionAdTypeIntersititialV2];
    intersititialV2SubParam.expectAdSize = CGSizeMake(600, 900);
    [array addObject:intersititialV2SubParam];
    
    
    XMAdUniversalSubParam *fullSubParam = [XMAdUniversalSubParam universalAdSubParamWithPosition:kDemoFullScreen adPositionAdType:XMAdPositionAdTypeFullScreen];
    [array addObject:fullSubParam];
    
    param.subParams = [NSSet setWithArray:array];
    return param;
    
}

- (IBAction)loadAd:(id)sender {
    
    [XMUniversalAdProvider setSplashAdProvider:SplashHelper.sharedInstance.splashProvider];
    BeginLoading;
    [XMUniversalAdProvider universalAdModelWithParam:[self createUniversalParam] completion:^(XMUniversalAd * _Nullable model, XMError * _Nullable error) {
        EndLoading;
        if (model) {
            self.messageLabel.text = @"获取广告成功";
            self.universalAd = model;
        } else {
            self.universalAd = nil;
            self.messageLabel.text = error.localizedDescription;
        }
    }];
}

- (IBAction)preloadAd:(id)sender {
    [XMUniversalAdProvider preloadAds:[self createUniversalParam]];
}

- (IBAction)getCacheAd:(id)sender {
    [XMUniversalAdProvider setSplashAdProvider:SplashHelper.sharedInstance.splashProvider];
    XMError *error;
    XMUniversalAd *universalAd = [XMUniversalAdProvider fetchUniversalAdAdFromCache:[self createUniversalParam] error:&error];
    if (universalAd) {
        self.messageLabel.text = @"获取缓存广告成功";
        _universalAd = universalAd;
    } else {
        _universalAd = nil;
        self.messageLabel.text = error.localizedDescription;
    }
}

- (IBAction)showAd:(id)sender {
    if (!self.universalAd) {
        self.messageLabel.text = @"暂无广告";
        return;
    }
    switch (self.universalAd.positionAdType) {
        case XMAdPositionAdTypeDraw:
        case XMAdPositionAdTypeFeed:
        case XMAdPositionAdTypeExpressBanner:
        case XMAdPositionAdTypePaster:
            [UniversalShowViewController showTextAd:self.universalAd];
            self.universalAd = nil;
            break;
            
        case XMAdPositionAdTypeSplash: {
            [self.universalAd.splashProvider presentWithCloseHandle:^{
                self.universalAd = nil;
                self.messageLabel.text = @"展示成功";
            }];
        }
            break;
        case XMAdPositionAdTypeNativeInterstitial: {
            [XMNativeIntersititialAdViewController showNativeIntersititialAd:self.universalAd.imgTextAd presentVC:self closeHandler:^{
                self.universalAd = nil;
                self.messageLabel.text = @"展示成功";
            }];
        }
            break;
        case XMAdPositionAdTypeFullScreen: {
            self.universalAd.fullScreenAd.adDelegate = self;
            [self.universalAd.fullScreenAd showFullScreenAdFromRootVC:self closeCompletion:^(BOOL success, NSString * _Nullable errMsg) {
                self.messageLabel.text = success ? @"播放成功" : errMsg;
                self.universalAd = nil;
            }];
        }
            break;
        case XMAdPositionAdTypeIntersititial:
        case XMAdPositionAdTypeIntersititialV2: {
            self.universalAd.intersititialAd.adDelegate = self;
            [self.universalAd.intersititialAd showIntersititialAdFromRootVC:self closeCompletion:^{
                self.messageLabel.text = @"展示成功";
                self.universalAd = nil;
            }];
        }
            break;
        case XMAdPositionAdTypeRewardVideo: {
            self.universalAd.rewardVideoAd.adDelegate = self;
            [self.universalAd.rewardVideoAd playAdFromVC:self playCompletion:^(BOOL success, NSString * _Nullable errMsg) {
                self.messageLabel.text = success ? @"播放成功" : errMsg;
                self.universalAd = nil;
            }];
        }
            break;
        default:
            break;
    }
}

#pragma 插屏
/// 曝光回调
- (void)intersititialAdDidExposure:(XMIntersititialAd *)ad {
    NSLog(@"===%s====",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

/// 点击回调
- (void)intersititialAdDidClick:(XMIntersititialAd *)ad {
    NSLog(@"===%s====",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

/// 关闭
- (void)intersititialAdDidClose:(XMIntersititialAd *)ad {
    NSLog(@"===%s====",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,关闭",__func__]];
}

/// 关闭详情页回调
- (void)intersititialAdDetailPageDidClose:(XMIntersititialAd *)ad {
    NSLog(@"===%s====",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,详情页关闭",__func__]];
}

#pragma mark --全屏
- (void)fullScreenAdDidExposure:(XMFullScreenAd *)ad {
    NSLog(@"________%s______",__func__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

/// 点击回调
- (void)fullScreenAdDidClick:(XMFullScreenAd *)ad {
    NSLog(@"________%s______",__func__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

/// 关闭
- (void)fullScreenAdDidClose:(XMFullScreenAd *)ad {
    NSLog(@"________%s______",__func__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,关闭",__func__]];
}

/// 关闭详情页回调
- (void)fullScreenAdDetailPageDidClose:(XMFullScreenAd *)ad {
    NSLog(@"________%s______",__func__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,详情页关闭",__func__]];
}


#pragma mark ----激励视频
/// 曝光回调
- (void)videoAdDidExposure:(XMVideoAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

/// 点击回调
- (void)videoAdDidClick:(XMVideoAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

/// 关闭
- (void)videoAdDidClose:(XMVideoAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,关闭",__func__]];
}

/// 视频播放结束回调
- (void)videoAdPlayFinished:(BOOL)finished error:(XMError *)error {
    NSLog(@"----%s---",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,%@",__func__,finished?@"播放完成":@"播放失败"]];
}


@end
