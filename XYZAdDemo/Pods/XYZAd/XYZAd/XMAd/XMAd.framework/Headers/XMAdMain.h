//
//  XMAdMain.h
//  XMAd
//
//  Created by 大大东 on 2019/12/12.
//  Copyright © 2019 大大东. All rights reserved.
//


#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


/// 新获取广告云控URL
@interface XMAdURLS : NSObject

/// 新获取广告云控URL <required>
@property (nonatomic, copy, nullable) NSString *adCloudConfig_NewURL;

/// 上面这个接口的前置接口
@property (nonatomic, copy, nullable) NSString *adCloudConfig_NewURL_PreURL;

/// sdk请求日志
@property (nonatomic, copy, nullable) NSString *sdk_ReqLogURL;

/// sdk请求结束日志
@property (nonatomic, copy, nullable) NSString *sdk_ReqBackLogURL;

/// sdk展示日志
@property (nonatomic, copy, nullable) NSString *sdk_showLogURL;

/// sdk点击日志
@property (nonatomic, copy, nullable) NSString *sdk_clickLogURL;

/// 广告触发上报的url
@property (nonatomic, copy, nullable) NSString *sdk_triggerURL;

/// 视频播放完成上报的url
@property (nonatomic, copy, nullable) NSString *sdk_videoPlayURL;

/// 竞价上报url
@property (nonatomic, copy, nullable) NSString *sdk_biddingURL;
@end


typedef struct {
    NSString *appId;
    NSString *appKey;
    NSString *productId;// sigmob的 s2s功能必填
} XMPreInitInfo;

/// ⚠️ 预初始化三方SDK配置 <option>  (注意 设置哪个appid就会初始化哪个三方sdk)
@interface XMPreInitSDKAppids : NSObject

/// 穿山甲appid
@property (nonatomic, copy, nullable) NSString *bu_appid;

/// 广点通appid
@property (nonatomic, copy, nullable) NSString *gdt_appid;

/// 禾赞appid
@property (nonatomic, copy, nullable) NSString *hz_appid;

/// 游可赢appid
@property (nonatomic, copy, nullable) NSString *yky_appid;

/// 快手appid
@property (nonatomic, copy, nullable) NSString *ks_appid;

/// 百度appid
@property (nonatomic, copy, nullable) NSString *bd_appid;

/// MTG`s appid(坑爹的玩意)
@property (nonatomic, assign        ) XMPreInitInfo mtgInfo;

/// SigMobSdk
@property (nonatomic, assign        ) XMPreInitInfo smInfo;
@end



@interface XMAdConfig : NSObject

/// 获取广告配置 <required>
/// (注意 这是强引用)
@property (nonatomic, strong) id<XMAdConfigBridge> adConfigBridge;

/// 配置URL <option>
/// 优先级: 云控配置 > 此配置 > SDK默认配置
@property (nonatomic, strong, nullable) XMAdURLS *urlConfig;

/// 配置三方SDK提前初始化 <option>
/// 正常初始化三方SDK的时机, 是在业务发起对应请求时触发, 可能某些三方SDK会出现配置拉取慢/广告返回慢/首次无返回等问题
/// 通过此配置可选择 在XMAd初始化后 立即开始初始化指定的三方SDK 以避免上述问题
@property (nonatomic, strong, nullable) XMPreInitSDKAppids *appids;

@end




@interface XMAdMain : NSObject

/// 初始化方法
+ (void)admainWithConf:(XMAdConfig *)config;

/// 必须先使用上面的方法初始化后 才能访问此属性 否则throw exception
@property (nonatomic, strong, readonly, class) XMAdMain *admain;

/// 初始化配置参数
@property (nonatomic, strong, readonly) XMAdConfig *config;

/// 版本号
@property (nonatomic, copy, class, readonly) NSString *sdkVersion;



#pragma mark - 内部使用 请忽略
/// YES: 标记从后台回到APP , NO: 冷启动
@property (nonatomic, assign, readonly) BOOL hotOpenApp;

@end

NS_ASSUME_NONNULL_END
