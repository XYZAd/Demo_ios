//
//  TableViewCell.m
//  Demo
//
//  Created by C on 2020/9/1.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "AdTableViewCell.h"
#import "UIImageView+YYWebImage.h"
#import "Masonry.h"


@implementation AdTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    if (self.model.ad) {
        [self.model.ad unRegistAdContainer];
    }
    self.contentImageView.image = nil;
    self.contentLabel.text = nil;
    self.logoImageView.image = nil;
}

- (void)setModel:(XYZFeedCellModel *)model {
    [super setModel:model];
    [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:model.ad.coverImage.imgURL] options:YYWebImageOptionSetImageWithFadeAnimation];
    self.contentLabel.text = model.ad.adTitle;
    
#if Demo_Overseas == 0
    if (model.ad.imageMode == XMFeedADMode_VideoImage) {
        [self.contentImageView addSubview:model.ad.videoView];
        [model.ad.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentImageView);
        }];
    }
#endif
    if (model.ad.logoImage.image) {
        self.logoImageView.image = model.ad.logoImage.image;
    } else {
        [self.logoImageView yy_setImageWithURL:[NSURL URLWithString:model.ad.logoImage.imageURL] options:0];
    }
    [self.contentView bringSubviewToFront:self.logoImageView];
#if Demo_Overseas == 0
    [model.ad registerAdContainer:self.contentView ableClickViews:@[self.contentLabel,self.contentImageView] presentVC:[self currentViewController]];
#else
    [model.ad registerAdContainer:self.contentView clickableAssetViews:@{XMUnifiedNativeTitleAsset:self.contentLabel,XMUnifiedNativeBodyImageAsset:self.contentImageView} nonclickableAssetViews:@{} presentVC:[self currentViewController]];
#endif
        
   
}

- (UIViewController *)currentViewController {
    UIResponder *view = self;
    while (view.nextResponder) {
        if ([view.nextResponder isKindOfClass:UIViewController.class]) {
            break;
        }
        view = view.nextResponder;
    }
    return (UIViewController *)view.nextResponder;
}


@end

@implementation AdTextCell

- (void)setup {
    [super setup];
    self.contentImageView.hidden = YES;
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
    }];
    [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self.contentLabel);
        make.size.mas_equalTo(CGSizeMake(80, 24));
    }];
    
    
    
}


@end


@implementation AdGroupCell


@end

@implementation AdSmailCell

- (void)setup {
    [super setup];
    
    [self.contentImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@20);
        make.bottom.equalTo(@-20);
    }];
    
    
}

@end
