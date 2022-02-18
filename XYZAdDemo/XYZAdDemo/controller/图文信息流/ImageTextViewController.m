//
//  ImageTextViewController.m
//  Demo
//
//  Created by C on 2020/6/24.
//  Copyright © 2020 大大东. All rights reserved.
//
#import "ImageTextViewController.h"

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

- (IBAction)loadCacheAd:(id)sender {
    XMAdImgTextParam *param = [XMAdImgTextParam new];
    param.position = kDemoImgText;//imgtext//bigset
    param.expectAdSize = CGSizeMake(1280, 720);
    
    XMError *error;
    XMImgTextAd *ad = [XMImgTextAdProvider fetchImgTextAdFromCache:param error:&error];
    NSString *des = error ? error.userInfo[NSLocalizedDescriptionKey] : @"广告拉取成功";
    _messageLabel.text = des;
    if (ad) {
        _lastAd = ad;
        [self show:nil];
    }
}

- (IBAction)load:(id)sender {
    XMAdImgTextParam *param = [XMAdImgTextParam new];
    param.position = kDemoImgText;//imgtext//bigset
    param.expectAdSize = CGSizeMake(1280, 720);
    BeginLoading
    [XMImgTextAdProvider imgTextAdModelWithParam:param completion:^(XMImgTextAd * _Nullable model, XMError *_Nullable error) {
        EndLoading
        if (model) {
            //            self->_imageView.image = nil;
            //            self->_titleLabel.text = nil;
            self->_lastAd = model;
        }
        NSString *des = error ? error.userInfo[NSLocalizedDescriptionKey] : @"广告拉取成功";
        self->_messageLabel.text = des;
        if (model) {
            [self show:nil];
        }
    }];
}

- (IBAction)show:(id)sender {
    if (_imgTextAd) {
        [_imgTextAd unRegistAdContainer];
        _imageView.image = nil;
        _titleLabel.text = nil;
        _desLabel.text = nil;
        _logoImageView.image = nil;
        _appNameLabel.text = nil;
        _iconImageView.image = nil;
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
    if (_imgTextAd.materialMeta.imgTextRenderType == XMImgTextRenderTypeExpress) {
        XMAdExpressView *expressView = _imgTextAd.materialMeta.expressView;
        expressView.rootViewController = self;
        [self.bgView addSubview:expressView];
        [expressView renderAdIfNeed];
        [expressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    } else {
        NSArray *array = @[self.imageView,self.titleLabel,self.installButton,self.desLabel,self.appNameLabel,self.iconImageView,self.logoImageView];
                
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imgTextAd.materialMeta.coverImage.imgURL]]];
        _titleLabel.text = _imgTextAd.materialMeta.adTitle;
        XMAdImage *image = _imgTextAd.materialMeta.coverImage;
        _desLabel.text = _imgTextAd.materialMeta.adSubTitle;
        [_iconImageView yy_setImageWithURL:[NSURL URLWithString:_imgTextAd.materialMeta.iconUrl] options:0];
        _logoImageView.image = _imgTextAd.materialMeta.logoImage.image;
        _appNameLabel.text = _imgTextAd.materialMeta.adSource;
        [self.installButton setTitle:_imgTextAd.materialMeta.isAppAd ? @"install" : @"open" forState:UIControlStateNormal];
        CGFloat radio = image.imgWidth / CGRectGetWidth(self.imageView.frame);
        CGFloat imageHeight = image.imgHeight / radio;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = 20;
        
        if (_imgTextAd.materialMeta.imageMode == XMFeedADMode_VideoImage) {
            [self.bgView addSubview:_imgTextAd.materialMeta.videoView];
            _imgTextAd.materialMeta.videoView.backgroundColor = UIColor.yellowColor;
            [_imgTextAd.materialMeta.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.bgView);
                make.top.equalTo(self.imageView);
                make.width.mas_equalTo(CGRectGetWidth(self.imageView.frame));
                make.height.mas_equalTo(imageHeight);
            }];
        }
        [self.bgView bringSubviewToFront:self.logoImageView];
        [_imgTextAd registerAdContainer:self.bgView ableClickViews:array presentVC:self];
    }

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


@end
