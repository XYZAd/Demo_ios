//
//  UniversalDrawAdView.m
//  Demo
//
//  Created by C on 2022/2/24.
//  Copyright © 2022 大大东. All rights reserved.
//

#import "UniversalDrawAdView.h"

@interface UniversalDrawAdView()

@property (nonatomic, strong) XMImgTextAd *textAd;

@property (nonatomic, strong) UILabel   *titleLabel,
                                        *descLabel;

@property (nonatomic, strong) UIImageView   *coverImageView,
                                            *logoImageView;

@end

@implementation UniversalDrawAdView

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
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
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
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.bottom.equalTo(@-50);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_descLabel);
        make.bottom.equalTo(_descLabel.mas_top).offset(-10);
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
        _descLabel.text = _textAd.materialMeta.adSubTitle;
        _logoImageView.image = _textAd.materialMeta.logoImage.image;
        
        self.coverImageView.layer.masksToBounds = YES;
        self.coverImageView.layer.cornerRadius = 20;
        if (_textAd.materialMeta.imageMode == XMFeedADMode_VideoImage) {
            [self.coverImageView addSubview:_textAd.materialMeta.videoView];
            _textAd.materialMeta.videoView.backgroundColor = UIColor.yellowColor;
            [_textAd.materialMeta.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsZero);
            }];
        }
        [self.coverImageView bringSubviewToFront:self.logoImageView];
        [_textAd registerAdContainer:self ableClickViews:array presentVC:container];
    }
    
    
    
    
    
}


@end
