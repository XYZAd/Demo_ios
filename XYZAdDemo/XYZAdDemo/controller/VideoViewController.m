//
//  VideoViewController.m
//  Demo
//
//  Created by C on 2020/6/24.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "VideoViewController.h"
#import "BannerViewController.h"
#import "CustomViewController.h"
@interface VideoViewController () <XMVideoAdDelegate> {
    XMVideoAd *_videoAd;
    int _index;
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISwitch *muteContro;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    XMAdParam *para = [XMAdParam new];
//    para.position = @"rewardvideonormal";
//    [XMVideoAdProvider preloadAds:para];
}

- (IBAction)load:(id)sender {
    
    XMAdParam *para = [XMAdParam new];

    para.position = kDemoRewardVideo;
    para.gametypeID = @"test";
    BeginLoading
    [XMVideoAdProvider videoAdModelWithParam:para completion:^(XMVideoAd * _Nullable model, XMError *_Nullable error) {
        EndLoading
        self->_index += 1;
        model.videoMuted = self.muteContro.on;
        self->_videoAd = model;
        self->_messageLabel.text = model ? @"广告加载成功" : (error.userInfo[NSLocalizedDescriptionKey] ? : @"广告加载失败");
    }];
    
}

- (IBAction)show:(id)sender {
    if (_videoAd) {
        _videoAd.adDelegate = self;
        [_videoAd playAdFromVC:self playCompletion:^(BOOL success, NSString * _Nullable errMsg) {
            self->_videoAd = nil;
            self->_messageLabel.text = success ? @"广告播放成功" : (errMsg ? : @"广告播放失败");
        }];
    } else {
        _messageLabel.text = @"请先拉取广告";
    }
}

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

- (UIView *)videoAdCustomExtraView:(XMVideoAd *)ad {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 140)];
    view.backgroundColor = UIColor.whiteColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10;
    UILabel *textLabel = [UILabel new];
    textLabel.numberOfLines = 0;
    textLabel.text = @"这里可以自定义一些控件，例如充值可以跳过看广告，成为vip可以免该位置广告等等，一般没有这种需求，建议不要实现这个协议，或者这个协议返回nil";
    textLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.bottom.right.equalTo(@(-10));
    }];
    
    return view;
}

/// 自定义的控件是否需要常驻页面从播放->结束，默认是只在播放页面
- (BOOL)videoAdCustomExtraViewAlwaysOnContainer:(XMVideoAd *)ad {
    return YES;
}

/// 自定义控件被点击了，这里可以做一些事件的处理
- (void)videoAdExtraViewDidClick:(XMVideoAd *)ad controller:(UIViewController *)vc {
    CustomViewController *cusVc = [CustomViewController new];
    cusVc.dismissBlock = ^{
        //参数：是否关闭视频
        [ad videoExtraContrainerDidClose:NO];
    };
    cusVc.modalPresentationStyle = UIModalPresentationCurrentContext;
    cusVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [vc presentViewController:cusVc animated:YES completion:nil];
}

@end
