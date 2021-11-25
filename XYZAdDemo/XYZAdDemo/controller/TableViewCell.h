//
//  TableViewCell.h
//  Demo
//
//  Created by C on 2020/9/1.
//  Copyright © 2020 大大东. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XYZFeedType) {
    XYZFeedType_Text     =       0,
    XYZFeedType_Ad       =       1,
};

typedef NS_ENUM(NSInteger, XYZLoadingState) {
    XYZLoadingState_Idle            = 0,
    XYZLoadingState_Reqing          = 1,
    XYZLoadingState_End             = 2,
};

@interface XYZFeedCellModel : NSObject


@property (nonatomic, assign) XYZFeedType feedType;

@property (nonatomic, strong) XMImgTextAd *ad;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *mainImageUrl;

@property (nonatomic, assign) XYZLoadingState loadingState;


@end



@class XMImgTextAd;

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *contentImageView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *logoImageView;

@property (nonatomic, strong) XYZFeedCellModel *model;

- (void)setup;

@end

NS_ASSUME_NONNULL_END
