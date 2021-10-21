//
//  ExpressDrawViewController.m
//  Demo
//
//  Created by C on 2020/9/8.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "ExpressDrawViewController.h"
#import "Masonry.h"


@interface ExpressDrawViewController ()<XMExpressDrawAdDelegate> {
    XMExpressDrawAd *_drawAdModel;
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation ExpressDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)load:(id)sender {
    XMAdExpressParam *para = [XMAdExpressParam new];
    para.position = kDemoExpressDraw;
    para.size = UIScreen.mainScreen.bounds.size;
    BeginLoading
    [XMExpressDrawAdProvider expressDrawVideoAdWithParam:para completion:^(XMExpressDrawAd * _Nullable model, XMError * _Nullable error) {
        EndLoading
        _drawAdModel = model;
        self.messageLabel.text = error ? error.userInfo[NSLocalizedDescriptionKey] : @"加载成功";
    }];
    
    
}
- (IBAction)dispaly:(id)sender {
    if (_drawAdModel) {
        _drawAdModel.rootViewController = self;
        _drawAdModel.adDelegate = self;
        UIView *v = _drawAdModel.drawView;
        [self.view addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.mas_equalTo(84);
        }];
        [_drawAdModel render];
    }
}

- (void)expressDrawAdRender:(XMExpressDrawAd *)ad error:(XMError *)error {
    NSLog(@"----%s---",__FUNCTION__);
}

/// 曝光回调
- (void)expressDrawAdDidExposure:(XMExpressDrawAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
}

/// 点击回调
- (void)expressDrawAdDidClick:(XMExpressDrawAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
}

/// 播放完成
- (void)expressDrawAdPlayFinished:(XMExpressDrawAd *)ad error:(XMError *)error {
    NSLog(@"----%s---",__FUNCTION__);
}

/// 视频播放状态
- (void)expressDrawAdMediaPlaying:(XMExpressDrawAd *)ad playerStatusChanged:(XMAdMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo {
    NSLog(@"----%s---",__FUNCTION__);
}

/// 关闭详情页回调
- (void)expressDrawAdDetailPageDidClose:(XMExpressDrawAd *)ad {
    NSLog(@"----%s---",__FUNCTION__);
}


@end

