//
//  FullScreenViewController.m
//  Demo
//
//  Created by C on 2021/8/17.
//  Copyright © 2021 大大东. All rights reserved.
//

#import "FullScreenViewController.h"

@interface FullScreenViewController () <XMFullScreenAdDelegate> {
    XMFullScreenAd *_fullAd;
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation FullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loadAd:(id)sender {
    XMAdParam *pa = [XMAdParam new];
    pa.position = kDemoFullScreen;
    BeginLoading
    [XMFullScreenAdProvider fullScreenAdWithParam:pa completion:^(XMFullScreenAd * _Nullable model, XMError * _Nullable error) {
        EndLoading
        if (error) {
            self.messageLabel.text = error.localizedDescription;
        } else {
            self.messageLabel.text = @"加载成功";
            _fullAd = model;
        }

    }];
}

- (IBAction)showAd:(id)sender {
    if (!_fullAd) {
        self.messageLabel.text = @"请先加载广告";
        return;
    }
    _fullAd.adDelegate = self;
    XM_WEAK_SELF;
    [_fullAd showFullScreenAdFromRootVC:self closeCompletion:^(BOOL success, NSString *msg){
        XM_STRONG_SELF_AutoReturn;
        strongSelf->_fullAd = nil;
        if (msg) {
            self.messageLabel.text = msg;
        } else {
            self.messageLabel.text = @"播放成功";
        }
    }];
}

- (void)fullScreenAdDidExposure:(XMFullScreenAd *)ad {
    NSLog(@"________%s______",__func__);
}

/// 点击回调
- (void)fullScreenAdDidClick:(XMFullScreenAd *)ad {
    NSLog(@"________%s______",__func__);
}

/// 关闭
- (void)fullScreenAdDidClose:(XMFullScreenAd *)ad {
    NSLog(@"________%s______",__func__);
}

/// 关闭详情页回调
- (void)fullScreenAdDetailPageDidClose:(XMFullScreenAd *)ad {
    NSLog(@"________%s______",__func__);
}

@end
