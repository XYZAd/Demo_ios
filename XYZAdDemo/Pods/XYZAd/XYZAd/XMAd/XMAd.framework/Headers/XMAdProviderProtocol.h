//
//  XMAdProviderProtocol.h
//  XMAd
//
//  Created by 大大东 on 2019/12/25.
//  Copyright © 2019 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMAdParam;
NS_ASSUME_NONNULL_BEGIN

@protocol XMAdProviderProtocol <NSObject>

/// 重置这个广告位的配置
/// 会重新根据云控/本地配置重新生成配置信息 (可能会导致调用- ad_localConfigWithPosition:)
+ (void)resetConfigWithPosition:(XMAdPageType *)useposition;

@optional

/// 云控是否有效
+ (BOOL)adClouldValidWithPosition:(XMAdPageType *)position;


/// 清空本地配置（重新获取云控）
+ (void)clearLocalXMAdInfo:(XMAdPageType *)position;



@end

NS_ASSUME_NONNULL_END
