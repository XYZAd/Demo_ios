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
}
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;


@end

@implementation XMIntersititialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.widthLabel.text = @(CGRectGetWidth(UIScreen.mainScreen.bounds)).stringValue;
    self.heightLabel.text = @(CGRectGetHeight(UIScreen.mainScreen.bounds)).stringValue;
    
    
 
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
    XMAdExpressParam *param = [XMAdExpressParam new];
    param.position = kDemoInitial;
    param.size = CGSizeMake(self.widthLabel.text.floatValue, self.heightLabel.text.floatValue);
    BeginLoading
    [XMIntersititialAdProvider intersititialAdModelWithParam:param completion:^(XMIntersititialAd * _Nullable model, XMError * _Nullable error) {
        EndLoading
        self->_errorMessageLabel.text = model ? @"加载成功" : @"加载失败";
        self->_intersititialAd = model;
        model.adDelegate = self;
    }];
    
}

- (IBAction)show:(id)sender {
    if (_intersititialAd) {
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
}

/// 点击回调
- (void)intersititialAdDidClick:(XMIntersititialAd *)ad {
    NSLog(@"===%s====",__FUNCTION__);
}

/// 关闭
- (void)intersititialAdDidClose:(XMIntersititialAd *)ad {
    NSLog(@"===%s====",__FUNCTION__);
}

/// 关闭详情页回调
- (void)intersititialAdDetailPageDidClose:(XMIntersititialAd *)ad {
    NSLog(@"===%s====",__FUNCTION__);
}

@end

