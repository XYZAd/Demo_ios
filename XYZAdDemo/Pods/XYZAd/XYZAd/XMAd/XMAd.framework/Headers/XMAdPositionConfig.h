//
//  XMAdPositionConfig.h
//  XMAd
//
//  Created by C on 2020/7/28.
//  Copyright © 2020 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface XMAdPositionConfig : NSObject
/// 广告类型
@property (nonatomic, copy) XMAdKey adtype;

/// 广告位id
@property (nonatomic, copy) NSString *tagid;

/// 应用id
@property (nonatomic, copy) NSString *appid;

/// 请求数量
@property (nonatomic, assign) NSUInteger numbers;

/// 权重（为0时无效）
@property (nonatomic, assign) NSInteger weights;

/// 是否是模版（暂时只有穿山甲才会区分模版和非模版，其他sdk则忽略这个值）
@property (nonatomic, assign) BOOL istemplate;
@end

NS_ASSUME_NONNULL_END
