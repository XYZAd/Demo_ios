//
//  XMImgTextData.h
//  XMAd
//
//  Created by C on 2021/3/12.
//  Copyright © 2021 XMAd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XMFeedADMode) {
    XMFeedADMode_LargeImage                  = 0 , ///图文(大图)
    XMFeedADMode_GroupImage                      , ///组图
    XMFeedADMode_SmallImage                      , ///单图
    XMFeedADMode_VideoImage                      , ///视频
};

/// 图片
@interface XMAdImage : NSObject

@property (nonatomic, copy  ) NSString *imgURL;
@property (nonatomic, assign) CGFloat   imgWidth;       // may be equal 0
@property (nonatomic, assign) CGFloat   imgHeight;      // may be equal 0

@end

@interface XMLogoImage : NSObject

/// 资源图片（本地资源读取）如果imageURL有值，image可能为nil
@property (nonatomic, strong, nullable) UIImage *image;
/// 资源图片地址链接（接口返回）可能为nil
@property (nonatomic, copy, nullable) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
