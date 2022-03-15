//
//  AppDelegate.m
//  XYZAdDemo
//
//  Created by C on 2021/8/27.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <XMCommon/XMCommon.h>
#import <XMAd/XMAd.h>
#import "SplashHelper.h"

@interface AppDelegate () <XMDynamicParamBridge, XMAdConfigBridge> {
    
    NSTimeInterval _enterBackgroundInterval;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *rootVC = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = nav ;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self preInitVenderSDK];
    return YES;
}

- (void)preInitVenderSDK {
    
    XMCfigParams *param = [[XMCfigParams alloc] init];
    // 这个是必填项，项目的唯一id，跟广告的appid不一样，具体可以咨询运营
    param.APP_TypeId  = @"xxxxx";
    
    /// 这里可以设置环境，例如test是测试环境，默认是正式环境
//    param.sdkRunMode = XMSDKRunModeITest;
    
    /// 设置log打印级别，默认是只输出error
    param.logLevel = XMSDKLogLevelAll;

    
    [XMCommonMgr setupWithConfig:param paramBridge:self];

    //这里必须先初始化XMCommonMgr
    // Ad
    XMAdConfig *adCondig = [[XMAdConfig alloc] init];
    // 请传入实现了XMAdConfigBridge的对象
    adCondig.adConfigBridge              = self;
    /// 设置三方广告的appid（可选，可设置可不设置）
    XMPreInitSDKAppids *appids = [XMPreInitSDKAppids new];
    
    adCondig.appids = appids;
    [XMAdMain admainWithConf:adCondig];
    
   //开屏
    CGSize size = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds) / 10 * 8.4);
    [[SplashHelper sharedInstance] loadSplashWithSize:size];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    _enterBackgroundInterval = [[NSDate date] timeIntervalSince1970];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (_enterBackgroundInterval <= 0) {
        return;
    }
    _enterBackgroundInterval = 0;
    CGSize size = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds) / 10 * 8.4);
    [[SplashHelper sharedInstance] loadSplashWithSize:size];
}

/// 这里提供一些打底（默认的一些广告配置），也可以不设置，可以理解为容错，让接口挂掉或者拿不到配置时，走下面协议
- (NSArray<XMAdPositionConfig *> *)ad_localConfigWithPosition:(XMAdPageType *)position {
    // 例如
    if ([position isEqualToString:@"test"]) {
        XMAdPositionConfig *conf = [XMAdPositionConfig new];
        conf.adtype = kGDTSDKAdKey;/// 设置请求广告源
        conf.weights = 100;        /// 设置单价
        conf.numbers = 1;          /// 请求数量（一般对图文有效，默认1）
        conf.appid = @"xxxx";      /// 设置广告的appid
        conf.tagid = @"xxxx";      /// 设置广告位的tagid
        return @[conf];
    }
    return nil;
}


@end
