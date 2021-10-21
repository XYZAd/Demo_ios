//
//  XMVideoExtraProtocol.h
//  XMAd
//
//  Created by C on 2020/9/7.
//  Copyright © 2020 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XMVideoExtraDelegate <NSObject>


/// 自定义详情页关闭后。调用该方法
/// @param cancelReward 是否取消视频
- (void)videoExtraContrainerDidClose:(BOOL)cancelReward;

@end

NS_ASSUME_NONNULL_END
