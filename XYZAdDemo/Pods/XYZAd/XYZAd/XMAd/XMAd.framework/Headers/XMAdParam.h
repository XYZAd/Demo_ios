//
//  XMAdParam.h
//  XMAd
//
//  Created by C on 2020/12/17.
//  Copyright © 2020 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 请求广告时 需要的基础参数
@interface XMAdParam : NSObject

/// 广告位置
@property (nonatomic, copy  ) XMAdPageType *position;

/// 类型（区分是哪个位置）
@property (nonatomic, copy  ) NSString *gametypeID;

/// 请求超时时间 (当<=0时无效, 使用SDK默认时间)
@property (nonatomic, assign) NSTimeInterval reqTimeout;

@end


/** 模板类广告请求时 需要的参数*/
@interface XMAdExpressParam : XMAdParam

/// 模板size
@property (nonatomic, assign) CGSize size;

@end


/** Banner广告请求时 需要的参数*/
@interface XMAdBannerParam : XMAdParam

/// 显示size
@property (nonatomic, assign) CGSize size;

/// 当前页面VC
@property (nonatomic, weak  ) UIViewController *viewController;

/// 自动切换时间间隔, 区间为[30 120], 为0时等价于关闭, 默认值0
@property (nonatomic, assign) int autoSwitchInterval;

@end



NS_ASSUME_NONNULL_END
