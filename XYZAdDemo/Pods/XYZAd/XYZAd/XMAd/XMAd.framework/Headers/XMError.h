//
//  XMError.h
//  XMAd
//
//  Created by C on 2020/7/6.
//  Copyright © 2020 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const XMAdErrorDomain;


typedef NS_ENUM(NSInteger, XMADErrorCode) {
    XMADErrorCode_None              = 0,
    XMADErrorCode_Req_timeout       = 1,///请求超时
    XMADErrorCode_Clould_close      = 3,///云控关闭
    XMADErrorCode_Repeat_req        = 4,///重复的连续请求 回调block会更新为最后一次调用传递的
    XMADErrorCode_Data_invalid      = 5,///无效的数据
    XMADErrorCode_Unsupport_req     = 6,///不支持的类型请求
    
    XMADErrorCode_Position_invalid  = 7,///position无效
    XMADErrorCode_Complete_invalid  = 8,///回调无效
    XMADErrorCode_Cancel            = 9,/// 请求被取消，一般是开屏前后台切换
    
    XMADErrorCode_Video_Cancel      = 10,///用户取消播放
    XMADErrorCode_Vip_Close         = 11,///付费取消
    XMADErrorCode_Ad_Metra_invalid  = 12,///广告数据无效，没有封面图
    
    XMADErrorCode_Ad_RewardVideo_limit      = 13,///激励视频展现上限
    XMADErrorCode_RootVC_invalid    = 14,///rootvc无效
    
    XMADErrorCode_ClouldLimit       = 15, /// 云控限制请求
    
    XMADErrorCode_PriceTooLow       = 16, /// 价格太低
    
    XMADErrorCode_unknown_error     = 9999, /// 未知错误
    
};


@interface XMError : NSError

+ (instancetype)errorWithCode:(NSInteger)code userInfo:(NSDictionary<NSErrorUserInfoKey,id> *)dict;

@end

NS_ASSUME_NONNULL_END
