//
//  XMCommonUserInfoParam.h
//  XMCommon
//
//  Created by C on 2020/7/15.
//  Copyright © 2020 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMCommonUserInfoParam : NSObject

/// 性别:1-男；2-女" 0-未知
@property (nonatomic, copy, nullable) NSString *sex;

/// 生日:格式：1990-05-06
@property (nonatomic, copy, nullable) NSString *birthday;

/// 注册时间，注册信息返回，1579509208,单位s
@property (nonatomic, copy, nullable) NSString *registDate;

/// 账号类型/三方账号类型：0-游客；1-手机；2-微信；3-QQ；4-vivo；5-微博；6-华为"（没有用到传null）
@property (nonatomic, copy, nullable) NSString *userType;


/// 新增自定义属性，如果里面 sex/bd/regts/lastinstall/usertype，则优先取值customUserInfo
@property (nonatomic, copy, nullable) NSDictionary *customUserInfo;

@end

NS_ASSUME_NONNULL_END
