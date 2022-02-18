//
//  ImgTextCollectionViewCell.m
//  Demo
//
//  Created by C on 2022/1/25.
//  Copyright © 2022 大大东. All rights reserved.
//

#import "ImgTextCollectionViewCell.h"

@interface ImgTextCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end


@implementation ImgTextCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [_adModel unRegistAdContainer];
    _mainImageView.image = nil;
    _logoImageView.image = nil;
    _titleLabel.text = nil;
    _descriptionLabel.text = nil;
}

- (void)setAdModel:(XMImgTextAd *)adModel {
    _adModel = adModel;
    XMVideoConfig *config = [XMVideoConfig new];
    config.drawVideoClickEnable = YES;
    if (_adModel.materialMeta.imgTextRenderType == XMImgTextRenderTypeNative) {
        _adModel.materialMeta.videoView.videoConfig = config;
        [_mainImageView yy_setImageWithURL:[NSURL URLWithString:adModel.materialMeta.coverImage.imgURL] options:0];
        _titleLabel.text = adModel.materialMeta.adTitle;
        _descriptionLabel.text = adModel.materialMeta.adSubTitle;
        if (_adModel.materialMeta.imageMode == XMFeedADMode_VideoImage) {
            UIView *videoView = _adModel.materialMeta.videoView;
            [_mainImageView addSubview:videoView];
            [videoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsZero);
            }];
        }
        /// set logo
        if (_adModel.materialMeta.logoImage.image) {
            _logoImageView.image = _adModel.materialMeta.logoImage.image;
        }
        [_adModel registerAdContainer:self.contentView ableClickViews:@[self.titleLabel,self.descriptionLabel] presentVC:self.controller];
        
    } else {
        // 模版
        XMAdExpressView *expressView = _adModel.materialMeta.expressView;
        expressView.videoConfig = config;
        expressView.rootViewController = self.controller;
        [expressView renderAdIfNeed];
        [self.contentView addSubview:expressView];
        [expressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [expressView renderAdIfNeed];
    }
}

@end
