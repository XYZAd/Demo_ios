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


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (void)setup {
    _contentImageView = [UIImageView new];
    [self.contentView addSubview:_contentImageView];
    
    _logoImageView = [UIImageView new];
    _logoImageView.contentMode = UIViewContentModeRight;
    [self.contentView addSubview:_logoImageView];
    
    _contentLabel = [UILabel new];
    [self.contentView addSubview:_contentLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@-20);
        make.left.equalTo(@20);
        make.height.mas_equalTo(30);
    }];
    
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(_contentLabel.mas_top).offset(-20);
    }];
   
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 24));
        make.bottom.right.equalTo(_contentImageView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(XYZFeedCellModel *)model {
    _model = model;
    self.contentLabel.text = model.title;
    [self.contentImageView yy_setImageWithURL:[NSURL URLWithString:model.mainImageUrl] options:0];
}

@end
