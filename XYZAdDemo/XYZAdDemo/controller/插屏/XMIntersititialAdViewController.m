//
//  XMIntersititialAdViewController.m
//  Demo
//
//  Created by C on 2020/6/29.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "XMIntersititialAdViewController.h"


@interface XMIntersititialAdViewController () <XMIntersititialAdDelegate> {
    XMIntersititialAd *_intersititialAd;
    
    BOOL _newInterStyle;
}
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UISwitch *muteControl;


@end

@implementation XMIntersititialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.widthLabel.text = @(CGRectGetWidth(UIScreen.mainScreen.bounds)).stringValue;
    self.heightLabel.text = @(CGRectGetHeight(UIScreen.mainScreen.bounds)).stringValue;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新插屏" style:UIBarButtonItemStylePlain target:self action:@selector(changeStyle)];
    
    
 
}

- (void)changeStyle {
    
    _newInterStyle = !_newInterStyle;
    self.navigationItem.rightBarButtonItem.title = _newInterStyle ? @"老插屏" : @"新插屏";
    self.navigationItem.title = _newInterStyle? @"新插屏广告": @"老插屏广告";
    
}

- (IBAction)widthSlider:(UISlider *)sender {
    CGFloat width = CGRectGetWidth(UIScreen.mainScreen.bounds) * sender.value;
    self.widthLabel.text = @((int)width).stringValue;
    
}
- (IBAction)heightSlider:(UISlider *)sender {
    CGFloat height = CGRectGetHeight(UIScreen.mainScreen.bounds) * sender.value;
    self.heightLabel.text = @((int)height).stringValue;
}

- (IBAction)load:(id)sender {
    XMAdIntersititialParam *param = [XMAdIntersititialParam new];
    param.interstitialType = _newInterStyle ? XMAdPositionAdTypeIntersititialV2 : XMAdPositionAdTypeIntersititial;
    param.position = _newInterStyle ? kDemoNewInitial : kDemoInitial;
    param.size = CGSizeMake(300, 450);
    BeginLoading
    [XMIntersititialAdProvider intersititialAdModelWithParam:param completion:^(XMIntersititialAd * _Nullable model, XMError * _Nullable error) {
        EndLoading
        self->_errorMessageLabel.text = model ? @"加载成功" : (error.localizedDescription? : @"加载失败");
        self->_intersititialAd = model;
        model.adDelegate = self;
    }];
    
}

- (IBAction)show:(id)sender {
    if (_intersititialAd) {
        _intersititialAd.videoMuted = self.muteControl.on;
        [_intersititialAd showIntersititialAdFromRootVC:self closeCompletion:^{
            self->_errorMessageLabel.text = @"展示成功";
            self->_intersititialAd = nil;
        }];
    } else {
        _errorMessageLabel.text = @"没有广告";
    }
}


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


@end

