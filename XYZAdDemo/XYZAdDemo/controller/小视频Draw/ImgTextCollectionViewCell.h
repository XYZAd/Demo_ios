//
//  ImgTextCollectionViewCell.h
//  Demo
//
//  Created by C on 2022/1/25.
//  Copyright © 2022 大大东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImgTextCollectionViewCell : UICollectionViewCell


@property (nonatomic) XMImgTextAd *adModel;

@property (nonatomic, weak) UIViewController *controller;

@end

NS_ASSUME_NONNULL_END
