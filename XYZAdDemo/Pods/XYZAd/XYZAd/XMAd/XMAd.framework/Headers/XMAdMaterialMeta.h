//
//  XMAdMaterialMeta.h
//  XMAd
//
//  Created by C on 2020/9/4.
//  Copyright © 2020 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMAdMaterialMeta : NSObject

/// 应用id
@property (nonatomic, copy) NSString *appid;

/// 广告位id
@property (nonatomic, copy) NSString *slotid;

/// 广告位置
@property (nonatomic, copy) XMAdPageType *adposition;

/// 广告类型
@property (nonatomic, assign) XMAdSourceType adsource;


@property (nonatomic, copy) NSString *gametype;

/// 广告单价标签
@property (nonatomic, copy) NSString *ecpmLevel;

@end

NS_ASSUME_NONNULL_END
