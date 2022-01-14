//
//  XMNativeIntersititialAdViewController.m
//  Demo
//
//  Created by C on 2021/12/29.
//  Copyright © 2021 大大东. All rights reserved.
//

#import "XMNativeIntersititialAdViewController.h"

@interface XMNativeIntersititialAdViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) XMImgTextAd *nativeAd;

@property (nonatomic, copy) void (^ closeBlock)(void);

@end

@implementation XMNativeIntersititialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _imageView = [UIImageView new];
    [self.view addSubview:_imageView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"close" forState:UIControlStateNormal];
    [closeBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_imageView.mas_right).offset(-8);
        make.top.equalTo(_imageView).offset(8);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [self initialAd];
}

- (void)initialAd {
    [_imageView yy_setImageWithURL:[NSURL URLWithString:self.nativeAd.coverImage.imgURL] options:0];
    
    UIView *bottomView = [UIView new];
    [bottomView setBackgroundColor:[UIColor colorWithWhite:0 alpha:.3]];
    [_imageView addSubview:bottomView];
    
    UILabel *titleLabel = [UILabel new];
    [titleLabel setText:self.nativeAd.adTitle ? : self.nativeAd.adSubTitle];
    titleLabel.font = [UIFont systemFontOfSize:12];
    [bottomView addSubview:titleLabel];
    
    UIImageView *logoImageView = [UIImageView new];
    [_imageView addSubview:logoImageView];
    
    UILabel *adStateLabel = [UILabel new];
    adStateLabel.font = [UIFont systemFontOfSize:14];
    adStateLabel.text = self.nativeAd.isAppAd ? @"立即下载" : @"查看详情";
    adStateLabel.textColor = UIColor.yellowColor;
    adStateLabel.layer.masksToBounds = YES;
    adStateLabel.layer.cornerRadius = 4;
    adStateLabel.layer.borderWidth = 1;
    adStateLabel.textAlignment = NSTextAlignmentCenter;
    adStateLabel.layer.borderColor = UIColor.redColor.CGColor;
    [bottomView addSubview:adStateLabel];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(40);
    }];
    
    [adStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@-5);
        make.width.mas_equalTo(70);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@5);
        make.right.equalTo(adStateLabel.mas_left).offset(-5);
    }];
    
    if (self.nativeAd.logoImage.image) {
        logoImageView.image = self.nativeAd.logoImage.image;
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(logoImageView.image.size);
            make.right.equalTo(bottomView.mas_right);
            make.bottom.equalTo(bottomView.mas_top).offset(-2);
        }];
    } else {
        [logoImageView yy_setImageWithURL:[NSURL URLWithString:self.nativeAd.logoImage.imageURL] placeholder:nil options:0 completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(image.size);
                make.right.equalTo(bottomView.mas_right);
                make.bottom.equalTo(bottomView.mas_top).offset(-2);
            }];
        }];
    }
   
    CGFloat width = CGRectGetWidth(UIScreen.mainScreen.bounds) - 80;
    CGFloat radio = self.nativeAd.coverImage.imgWidth / width;
    CGFloat imageHeight = self.nativeAd.coverImage.imgHeight / radio;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(width, imageHeight));
    }];
    
    if (self.nativeAd.imageMode == XMFeedADMode_VideoImage) {
        [self.imageView insertSubview:self.nativeAd.videoView atIndex:0];
        [self.nativeAd.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    [self.nativeAd registerAdContainer:self.view ableClickViews:@[self.imageView,titleLabel,logoImageView,adStateLabel] presentVC:self];
    
}

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:^{
        XM_BLOCK_EXEC(self.closeBlock);
    }];
}

+ (BOOL)showNativeIntersititialAd:(XMImgTextAd *)nativeIntersititial presentVC:(nonnull UIViewController *)vc closeHandler:(nonnull void (^)(void))complete {
    if (nativeIntersititial == nil || vc == nil || vc.presentedViewController) {
        return NO;
    }
    XMNativeIntersititialAdViewController *intersititialAd = [XMNativeIntersititialAdViewController new];
    intersititialAd.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    intersititialAd.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    intersititialAd.nativeAd = nativeIntersititial;
    intersititialAd.closeBlock = [complete copy];
    [vc presentViewController:intersititialAd animated:YES completion:nil];
    return YES;
}

@end
