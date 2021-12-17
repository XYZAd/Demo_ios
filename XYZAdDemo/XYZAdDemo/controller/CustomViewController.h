//
//  CustomViewController.h
//  Demo
//
//  Created by C on 2021/11/30.
//  Copyright © 2021 大大东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomViewController : UIViewController


@property (nonatomic, copy) void (^ dismissBlock)(void);

@end

NS_ASSUME_NONNULL_END
