//
//  XMCommonDef.h
//  XMCommon
//
//  Created by 大大东 on 2021/3/30.
//  Copyright © 2021 大大东. All rights reserved.
//

#ifndef XMCommonDef_h
#define XMCommonDef_h

//
typedef NS_ENUM(NSInteger, XMSDKRunMode) {
    XMSDKRunModeRelease = 0,
    XMSDKRunModeITest   = -999,  // URL改为测试环境
};

//
typedef NS_ENUM(NSInteger, XMSDKLogLevel) {
    XMSDKLogLevelError,
    XMSDKLogLevelAll,
    XMSDKLogLevelNone,
};


//
#define XM_BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

//
#define XM_WEAK_SELF       __weak __typeof(self)weakSelf = self;
#define XM_STRONG_SELF     __strong __typeof(weakSelf)strongSelf = weakSelf;
#define XM_STRONG_SELF_AutoReturn  __strong __typeof(weakSelf)strongSelf = weakSelf; if (!strongSelf) { return ;}


#endif /* XMCommonDef_h */
