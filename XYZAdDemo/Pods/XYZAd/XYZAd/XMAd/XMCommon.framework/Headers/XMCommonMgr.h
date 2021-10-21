//
//  XMCommonMgr.h
//  XMCommon
//
//  Created by 大大东 on 2021/3/30.
//  Copyright © 2021 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMCfigParams : NSObject

// <required>
/// apptypeid
@property (nonatomic, copy  ) NSString *APP_TypeId;

// <option>
/// SDK内接口环境配置(请注意上线前 一定要设置为 XMSDKRunModeRelease)
@property (nonatomic, assign) XMSDKRunMode sdkRunMode;
/// 日志输出
@property (nonatomic, assign) XMSDKLogLevel logLevel;
/// 是否允许SDK初始化时请求IDFA权限(defult YES)
@property (nonatomic, assign) BOOL allowFireIDFAAuth;

@end


@protocol XMDynamicParamBridge;

@interface XMCommonMgr : NSObject


/// 初始化SDK
/// @param param       配置参数
/// @param paramBridge 动态配置参数代理
+ (void)setupWithConfig:(XMCfigParams *)param
            paramBridge:(nullable id<XMDynamicParamBridge>)paramBridge;

/// 版本号
+ (NSString *)sdkVersion;

@end

NS_ASSUME_NONNULL_END
