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

@interface XYZFeedCellModel : NSObject


@property (nonatomic, assign) XYZFeedType feedType;

@property (nonatomic, strong) XMImgTextAd *ad;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *mainImageUrl;


@end



@class XMImgTextAd;

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (nonatomic, strong) XYZFeedCellModel *model;

@end

NS_ASSUME_NONNULL_END
