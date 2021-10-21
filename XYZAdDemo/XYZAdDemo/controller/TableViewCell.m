//
//  TableViewCell.m
//  Demo
//
//  Created by C on 2020/9/1.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+YYWebImage.h"
#import "Masonry.h"

@implementation XYZFeedCellModel

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

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
}

- (void)setModel:(XYZFeedCellModel *)model {
    _model = model;
    self.contentImageView.hidden = NO;
    if (_model.feedType == XYZFeedType_Ad) {
        [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:model.ad.coverImage.imgURL] options:YYWebImageOptionSetImageWithFadeAnimation];
        self.contentLabel.text = model.ad.adTitle;
        
        if (model.ad.videoView) {
            self.contentImageView.hidden = YES;
            [self.contentView addSubview:model.ad.videoView];
            [model.ad.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentImageView);
            }];
        }
        if (model.ad.logoImage.image) {
            self.logoImageView.image = model.ad.logoImage.image;
        } else {
            [self.logoImageView yy_setImageWithURL:[NSURL URLWithString:model.ad.logoImage.imageURL] options:0];
        }
        [self.contentView bringSubviewToFront:self.logoImageView];
        [model.ad registerAdContainer:self.contentView ableClickViews:@[self.contentLabel,self.contentImageView] presentVC:[self currentViewController]];
        
    } else {
        self.logoImageView.image = nil;
        self.contentLabel.text = model.title;
        [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:model.mainImageUrl] options:0];
    }
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
