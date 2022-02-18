//
//  NativeInterisititialViewController.m
//  Demo
//
//  Created by C on 2021/12/29.
//  Copyright © 2021 大大东. All rights reserved.
//

#import "NativeInterisititialViewController.h"
#import "XMNativeIntersititialAdViewController.h"

@interface NativeInterisititialViewController ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation NativeInterisititialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)loadAd:(id)sender {
    
    XMAdImgTextParam *params = [XMAdImgTextParam new];
    params.position = kDemoNativeInitial;
    params.gametypeID = @"text";
    params.adPositionAdType = XMAdPositionAdTypeNativeInterstitial;
    params.defaultImageSize = XMNativeImageSize1080x1920;
//    params.expectAdSize = CGSizeMake(300, 450);
    
    BeginLoading;
    [XMImgTextAdProvider imgTextAdModelWithParam:params completion:^(XMImgTextAd * _Nullable model, XMError * _Nullable error) {
        EndLoading;
        self.messageLabel.text = model ? @"广告加载成功" : (error.localizedDescription ? : @"广告加载失败");
        if (model) {
            [XMNativeIntersititialAdViewController showNativeIntersititialAd:model presentVC:self closeHandler:^{
                
            }];
        }
    }];
    
}


@end
