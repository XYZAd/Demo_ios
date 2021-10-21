//
//  VideoViewController.m
//  Demo
//
//  Created by C on 2020/6/24.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "VideoViewController.h"
#import "BannerViewController.h"

@interface VideoViewController () <XMVideoAdDelegate> {
    XMVideoAd *_videoAd;
    int _index;
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

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
}

/// 点击回调
- (void)videoAdDidClick:(XMVideoAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
}

/// 关闭
- (void)videoAdDidClose:(XMVideoAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
}

/// 视频播放结束回调
- (void)videoAdPlayFinished:(BOOL)finished error:(XMError *)error {
    NSLog(@"----%s---",__FUNCTION__);
}

- (UIView *)videoAdCustomExtraView:(XMVideoAd *)ad {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = UIColor.redColor;
    return view;
}

- (BOOL)videoAdCustomExtraViewAlwaysOnContainer:(XMVideoAd *)ad {
    return YES;
}

- (void)videoAdExtraViewDidClick:(XMVideoAd *)ad controller:(UIViewController *)vc {

    UIViewController *vc1 = [UIViewController new];
    vc1.modalPresentationStyle = UIModalPresentationCurrentContext;
    vc1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [vc presentViewController:vc1 animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vc1 dismissViewControllerAnimated:YES completion:
         ^{
            [ad videoExtraContrainerDidClose:NO];
        }];
    });

}

@end
