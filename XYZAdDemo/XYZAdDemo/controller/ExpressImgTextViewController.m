//
//  ExpressImgTextViewController.m
//  Demo_海外
//
//  Created by C on 2021/3/24.
//  Copyright © 2021 大大东. All rights reserved.
//

#import "ExpressImgTextViewController.h"
#import "Masonry.h"


@interface ExpressImgTextViewController () <XMExpressImgTextAdDelegate> {
    XMExpressImgTextAd *_expressAd;
    XMExpressImgTextAd *_lastAd;
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation ExpressImgTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loadAd:(id)sender {
    BeginLoading
    XMAdExpressParam *param = [XMAdExpressParam new];
    param.position = kDemoExpressImtText;
    param.size = CGSizeMake(320, 90);
    [XMExpressImgTextAdProvider expressImgTextAdModelWithParam:param
                                                    completion:^(XMExpressImgTextAd * _Nullable model, XMError * _Nullable error) {
        EndLoading
        _expressAd = model;
        if (error) {
            self.messageLabel.text = error.localizedDescription;
        } else {
            self.messageLabel.text = @"加载成功";
        }
    }];
}
- (IBAction)showAd:(id)sender {
    if (_lastAd) {
        [_expressAd unRender];
    }
    _lastAd = _expressAd;
    _expressAd.delegate = self;
    UIView *view = [_expressAd expressView];
    [self.view addSubview:view];
    view.backgroundColor = UIColor.redColor;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(300, 200));
    }];
    
    [_expressAd render];
}

- (void)expressImgTextAdDidClick:(XMExpressImgTextAd *)ad {
    NSLog(@"点击------%s-------",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

- (void)expressImgTextAdDidExposure:(XMExpressImgTextAd *)ad {
    NSLog(@"曝光------%s-------",__FUNCTION__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

- (UIViewController *)expressImgTextAdPresentViewController {
    return self;
}

@end
