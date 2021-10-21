//
//  XMAdDefine.h
//  XMAd
//
//  Created by 大大东 on 2019/12/12.
//  Copyright © 2019 大大东. All rights reserved.
//

#ifndef XMAdDefine_h
#define XMAdDefine_h

#import <UIKit/UIKit.h>

@class XMAdPositionConfig;

typedef NSString XMAdPageType;

/// 请实现此协议 提供云控/本地配置 <<<  勿修改   >>>
@protocol XMAdConfigBridge <NSObject>

- (NSArray<XMAdPositionConfig *> *)ad_localConfigWithPosition:(XMAdPageType *)position;

/// 部分APP对于dsp图文广告 存在每日最大可点击次数 （此协议只有 非下载类 dsp 图文 才会回调）
/// return YES时，外部需要持久化记录click++
/// return NO时，外部需要自行toast提示
/// 如果不需限制 可不实现 也可直接return YES
- (BOOL)canResponseDspImageTextAdClickAction;
@end


#pragma mark - <<<  勿修改   >>>

// data Type
typedef NS_ENUM(NSInteger, XMAdSourceType) {
    XMAdSourceTypeUnkonw,      /// 未知 错误类型
    XMAdSourceTypeDsp,         /// dsp
    XMAdSourceTypeJRTTSDK,     /// 今日头条SDK
    XMAdSourceTypeGDTSDK,      /// 广点通
    XMAdSourceTypeWYSDK,       /// 万裕
    XMAdSourceTypeKSSDK,       /// 快手
    XMAdSourceTypeYKYSDK,      /// 游可赢sdk
    XMAdSourceTypeBaiduSDK,    /// 百度sdk
    XMAdSourceTypeMTGSDK,      /// MTG sdk
    XMAdSourceTypeSMSDK,       /// sigMobSDK
};

typedef NS_ENUM(NSUInteger, XMAdMediaPlayerStatus) {
    XMAdMediaPlayerStatusInitial = 0,         /// 初始状态
    XMAdMediaPlayerStatusLoading = 1,         /// 加载中
    XMAdMediaPlayerStatusStarted = 2,         /// 开始播放
    XMAdMediaPlayerStatusPaused = 3,          /// 用户行为导致暂停
    XMAdMediaPlayerStatusStoped = 4,          /// 播放停止
    XMAdMediaPlayerStatusError = 5,           /// 播放出错
};
// cloud ad source Type

typedef NSString * XMAdKey;

/// 广点通
FOUNDATION_EXTERN XMAdKey const kGDTSDKAdKey;
/// 穿山甲
FOUNDATION_EXTERN XMAdKey const kJRTTSDKAdKey;
/// 禾赞
FOUNDATION_EXTERN XMAdKey const kDSPADKey;
/// 万裕聚合
FOUNDATION_EXTERN XMAdKey const kJHADKey;
/// 快手
FOUNDATION_EXTERN XMAdKey const kKSADKey;
/// 游可赢
FOUNDATION_EXPORT XMAdKey const kYKYADKey;
/// 百度
FOUNDATION_EXPORT XMAdKey const kBaiDuADKey;
/// MTG
FOUNDATION_EXPORT XMAdKey const kMTGADKey;
///sigMobSDK
FOUNDATION_EXPORT XMAdKey const kSMAdKey;

#endif /* XMAdDefine_h */
