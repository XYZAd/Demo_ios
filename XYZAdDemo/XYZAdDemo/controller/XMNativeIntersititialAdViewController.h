//
//  XMNativeIntersititialAdViewController.h
//  Demo
//
//  Created by C on 2021/12/29.
//  Copyright © 2021 大大东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMNativeIntersititialAdViewController : UIViewController

+ (BOOL)showNativeIntersititialAd:(XMImgTextAd *)nativeIntersititial presentVC:(UIViewController *)vc closeHandler:(void (^)(void))complete;

@end

NS_ASSUME_NONNULL_END
