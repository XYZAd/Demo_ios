//
//  XMDrawVideoAd.h
//  XMAd
//
//  Created by C on 2020/7/3.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "XMImgTextAd.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMDrawVideoAd : XMImgTextAd

/// 设置点击暂停
@property (nonatomic, assign) BOOL drawVideoClickEnable;


/// 设置icon图标和icon大小
/// @param playImg image
/// @param playSize size
- (void)playerPlayIncon:(UIImage *)playImg playInconSize:(CGSize)playSize;

@end

NS_ASSUME_NONNULL_END
