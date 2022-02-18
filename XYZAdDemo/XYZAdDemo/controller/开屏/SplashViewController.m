//
//  SplashViewController.m
//  Demo
//
//  Created by C on 2020/6/24.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController () <XMSplashAdDelegate> {
    CGSize _size;
    XMSplashAdProvider *_provider;

    
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation SplashViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _size = UIScreen.mainScreen.bounds.size;
    
}

- (IBAction)fullscreen:(id)sender {
    _size = UIScreen.mainScreen.bounds.size;
}

- (IBAction)middlescreen:(id)sender {
    _size = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds) / 10 * 8);
}

- (IBAction)splash:(id)sender {
    if (_provider == nil) {
        _provider = [[XMSplashAdProvider alloc] init];
        _provider.adDelegate = self;
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.yellowColor;
        _provider.customSplashBottomView = view;
    }
    XM_WEAK_SELF;
    BeginLoading
    XMAdParam *param = [XMAdParam new];
    param.position = kDemoSplash;
    [_provider adWithParam:param adsize:_size totalTime:5 completion:^(BOOL success, XMError *error) {
        XM_STRONG_SELF_AutoReturn;
        EndLoading
        NSLog(@"请求开屏结束");
        if (success) {
            [strongSelf->_provider presentWithCloseHandle:^{
                strongSelf.messageLabel.text = @"开屏成功";
                
            }];
        } else {
            strongSelf.messageLabel.text = error.userInfo[NSLocalizedDescriptionKey];
        }
    }];
}
/// 曝光回调
- (void)splashAdDidExposure:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    self.messageLabel.text = @"开屏曝光";
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

/// 点击回调
- (void)splashAdDidClick:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    self.messageLabel.text = @"开屏点击";
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

- (void)splashAdWillClose:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    self.messageLabel.text = @"开屏即将关闭";
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,即将关闭",__func__]];
}

/// 关闭
- (void)splashAdDidClose:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    self.messageLabel.text = @"开屏关闭";
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,关闭",__func__]];
}

/// 关闭详情页回调
- (void)splashAdDetailPageDidClose:(XMSplashAdProvider *)provider {
    NSLog(@"------%s--",__FUNCTION__);
    self.messageLabel.text = @"开屏详情页关闭";
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,详情页关闭",__func__]];
}


@end
