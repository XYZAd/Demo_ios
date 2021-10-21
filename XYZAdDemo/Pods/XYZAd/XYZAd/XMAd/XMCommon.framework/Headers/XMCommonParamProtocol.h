//
//  XMCommonParamProtocol.h
//  XMCommon
//
//  Created by C on 2020/7/15.
//  Copyright © 2020 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMCommonUserInfoParam;

NS_ASSUME_NONNULL_BEGIN

@protocol XMDynamicParamBridge <NSObject>

@optional
/// 用户token
@property (nonatomic, copy, readonly, nullable  ) NSString *userToken;

/// 用户accid
@property (nonatomic, copy, readonly, nullable  ) NSString *userAccid;

/// 登录接口返回的
@property (nonatomic, copy, readonly, nullable  ) NSString *userMUID;

/// 是否是游客
@property (nonatomic, assign, readonly          ) BOOL    userIsTourist;

/// 用户标识：0：非标识用户，1：任务用户 ,默认0，可不传
@property (nonatomic, copy, readonly, nullable  ) NSString *userflag;


/// userinfo公参参数
@property (nonatomic, strong, readonly, nullable) XMCommonUserInfoParam *userinfoParams;

@end


NS_ASSUME_NONNULL_END
