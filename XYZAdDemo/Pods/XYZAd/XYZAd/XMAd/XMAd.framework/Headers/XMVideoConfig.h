//
//  XMVideoConfig.h
//  XMAd
//
//  Created by C on 2020/9/7.
//  Copyright © 2020 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, XMVideoAutoPlayPolicy) {
    XMVideoAutoPlayPolicyWIFI = 0, // WIFI 下自动播放
    XMVideoAutoPlayPolicyAlways = 1, // 总是自动播放，无论网络条件
    XMVideoAutoPlayPolicyNever = 2, // 从不自动播放，无论网络条件
};

@interface XMVideoConfig : NSObject


//default always
@property (nonatomic, assign) XMVideoAutoPlayPolicy autoPlayPolicy;

/**
 是否静音播放视频广告，视频初始状态是否静音，默认 YES，
 */
@property (nonatomic, assign) BOOL videoMuted;

/**
 广告发生点击行为时，是否展示视频详情页(默认YES)
 设为 NO 时，用户点击 clickableViews 会直接打开 App Store 或者广告落地页
 */
@property (nonatomic, assign) BOOL detailPageEnable;


@end

NS_ASSUME_NONNULL_END
