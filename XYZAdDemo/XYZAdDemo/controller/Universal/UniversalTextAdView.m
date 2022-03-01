//
//  UniversalTextAdView.m
//  Demo
//
//  Created by C on 2022/2/24.
//  Copyright © 2022 大大东. All rights reserved.
//

#import "UniversalTextAdView.h"

@interface UniversalTextAdView()

@property (nonatomic, strong) XMImgTextAd *textAd;

@property (nonatomic, strong) UILabel   *titleLabel,
                                        *descLabel;

@property (nonatomic, strong) UIImageView   *coverImageView,
                                            *logoImageView;

@end

@implementation UniversalTextAdView

- (instancetype)initWithTextAd:(XMImgTextAd *)textAd container:(UIViewController *)container {
    if (self = [super init]) {
        _textAd = textAd;
        [self setup:container];
    }
    return self;
}

- (void)setup:(UIViewController *)container {
    self.backgroundColor = UIColor.whiteColor;
    _coverImageView = [[UIImageView alloc] init];
    [self addSubview:_coverImageView];
    
    
    _logoImageView = [UIImageView new];
    [self.coverImageView addSubview:_logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(25, 12));
    }];
    
    
    _titleLabel = [UILabel new];
    [self addSubview:_titleLabel];
    
    _descLabel = [UILabel new];
    [self addSubview:_descLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_coverImageView);
        make.top.equalTo(_coverImageView.mas_bottom).offset(10);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_coverImageView);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(@-10);
    }];
    
    
    if (_textAd.materialMeta.imgTextRenderType == XMImgTextRenderTypeExpress) {
        XMAdExpressView *expressView = _textAd.materialMeta.expressView;
        expressView.rootViewController = container;
        [self addSubview:expressView];
        [expressView renderAdIfNeed];
        [expressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    } else {
        NSArray *array = @[self.coverImageView,self.titleLabel,self.descLabel,self.logoImageView];
                
        self.coverImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_textAd.materialMeta.coverImage.imgURL]]];
        
        _titleLabel.text = _textAd.materialMeta.adTitle;
        XMAdImage *image = _textAd.materialMeta.coverImage;
        _descLabel.text = _textAd.materialMeta.adSubTitle;
        _logoImageView.image = _textAd.materialMeta.logoImage.image;
        
        self.coverImageView.layer.masksToBounds = YES;
        self.coverImageView.layer.cornerRadius = 20;
        CGFloat width = CGRectGetWidth(UIScreen.mainScreen.bounds) - 80;
        CGFloat radio = image.imgWidth / width;
        CGFloat imageHeight = image.imgHeight / MAX(1, radio);
        [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(@0);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(imageHeight);
            make.left.right.equalTo(@0);
        }];
        if (_textAd.materialMeta.imageMode == XMFeedADMode_VideoImage) {
            [self.coverImageView addSubview:_textAd.materialMeta.videoView];
            _textAd.materialMeta.videoView.backgroundColor = UIColor.yellowColor;
            [_textAd.materialMeta.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self.coverImageView);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(imageHeight);
            }];
        }
        [self.coverImageView bringSubviewToFront:self.logoImageView];
        [_textAd registerAdContainer:self ableClickViews:array presentVC:container];
    }
    
    
    
    
    
}


@end
