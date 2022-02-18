//
//  BannerViewController.m
//  Demo
//
//  Created by C on 2020/6/24.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "BannerViewController.h"

@interface BannerViewController () <XMBannerAdDelegate> {
    XMBannerAd *_bannerAd;
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.messageLabel.text = @"请先加载banner";
}

CGSize _size;

- (IBAction)loadBanner:(id)sender {
    _size = CGSizeMake(300, 150);
    XMAdBannerParam *param = [XMAdBannerParam new];
    param.position = kDemoBanner;
    param.autoSwitchInterval = 30;
    param.size = _size;
    param.viewController = self;
    BeginLoading
    [XMBannerAdProvider bannerAdModelWithParam:param completion:^(XMBannerAd * _Nullable model, XMError * _Nullable error) {
        EndLoading
        self.messageLabel.text = model ? @"加载banner成功" : (error.userInfo[NSLocalizedDescriptionKey] ? : @"加载banner失败");
        if (model) {
            [[self->_bannerAd adBannerView] removeFromSuperview];
            self->_bannerAd = model;
            model.adDelegate = self;
            [self showBannerView:[model adBannerView]];
        }
    }];
    
}

- (void)showBannerView:(UIView *)banner {
    banner.backgroundColor = UIColor.redColor;
    [self.view addSubview:banner];
    banner.layer.borderColor = UIColor.redColor.CGColor;
    banner.layer.borderWidth = 1;
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(_size);
    }];
}

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

@end

