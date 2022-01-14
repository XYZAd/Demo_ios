//
//  ImageTextViewController.m
//  Demo
//
//  Created by C on 2020/6/24.
//  Copyright © 2020 大大东. All rights reserved.
//
#import <objc/runtime.h>
#import "ImageTextViewController.h"
#import "Masonry.h"
#import "VideoViewController.h"
#import "YYWebImage.h"


@interface ImageTextViewController () <XMImgTextAdDelegate> {
    XMImgTextAd *_imgTextAd;
    XMImgTextAd *_lastAd;
    NSInteger _index;
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *installButton;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation ImageTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView.backgroundColor = UIColor.redColor;
    
}

- (IBAction)load:(id)sender {
    XMAdParam *param = [XMAdParam new];
    param.position = kDemoImgText;
    
    //如果集成了京东广告，则需要设置下面这个参数
    param.nativeImageSize = CGSizeMake(1280, 720);
    BeginLoading
    [XMImgTextAdProvider imgTextAdModelWithParam:param completion:^(XMImgTextAd * _Nullable model, XMError *_Nullable error) {
        EndLoading
        if (model) {
            self->_lastAd = model;
        }
        NSString *des = error ? error.userInfo[NSLocalizedDescriptionKey] : @"广告拉取成功";
        self->_messageLabel.text = des;
    }];
}

- (IBAction)show:(id)sender {
    if (_imgTextAd) {
        [_imgTextAd unRegistAdContainer];
    }
    if (!_lastAd && !_imgTextAd) {
        _messageLabel.text = @"没有广告";
        return;
    }
    _imgTextAd = _lastAd;
    _imgTextAd.adDelegate = self;
    _lastAd = nil;
    if (_imgTextAd == nil) {
//        _messageLabel.text = @"没有广告";
        return;
    }
    NSMutableArray *array = @[].mutableCopy;
    
    [array addObjectsFromArray: @[self.imageView,self.titleLabel]];
    
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgTextAd.coverImage.imgURL]]];
    _titleLabel.text = _imgTextAd.adTitle;
    XMAdImage *image = _imgTextAd.coverImage;
    _desLabel.text = _imgTextAd.adSubTitle;
    [_iconImageView yy_setImageWithURL:[NSURL URLWithString:_imgTextAd.iconUrl] options:0];
    _logoImageView.image = _imgTextAd.logoImage.image;
    _appNameLabel.text = _imgTextAd.adSource;
    [self.installButton setTitle:@"install" forState:UIControlStateNormal];
    CGFloat radio = image.imgWidth / CGRectGetWidth(self.imageView.frame);
    CGFloat imageHeight = image.imgHeight / radio;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 20;
    
    if (_imgTextAd.imageMode == XMFeedADMode_VideoImage) {
        [self.bgView addSubview:_imgTextAd.videoView];
        _imgTextAd.videoView.backgroundColor = UIColor.yellowColor;
        [_imgTextAd.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.imageView);
            make.width.mas_equalTo(CGRectGetWidth(self.imageView.frame));
            make.height.mas_equalTo(imageHeight);
        }];
    }
    [self.bgView bringSubviewToFront:self.logoImageView];
    [_imgTextAd registerAdContainer:self.bgView ableClickViews:array presentVC:self];

}

- (void)imgTextAdDidExposure:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

- (void)imgTextAdDidClick:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

- (void)imgTextAdDetailPageDidClose:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,详情页关闭",__func__]];
}

- (void)imgTextAdDelete:(XMImgTextAd *)ad dislikeReason:(NSString *)reason {
    
}

@end
