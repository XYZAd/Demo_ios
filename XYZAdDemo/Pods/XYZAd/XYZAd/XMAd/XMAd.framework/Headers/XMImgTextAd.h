//
//  XMImgTextAd.h
//  XMAd
//
//  Created by 大大东 on 2019/12/26.
//  Copyright © 2019 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMAd/XMImgTextData.h>

@class XMAdModel;
@class XMError;
@class XMAdMaterialMeta,XMVideoConfig;
NS_ASSUME_NONNULL_BEGIN



@protocol XMImgTextAdDelegate;

@interface XMImgTextAd : NSObject

- (instancetype)initWithModel:(XMAdModel *)model;

@property (nonatomic, strong, readonly) XMAdModel *adModel;

@property (nonatomic, copy, readonly, nullable) NSString
        *adTitle,      // 标题
        *adSubTitle,   // 副标题
        *adSource,     // jrtt取自nativeAd.data.source , gdt写死了”广点通“
        *iconUrl;   //iconURL，dsp的没有，是nil

/// 封面 优先封面 其次取第一张小图
@property (nonatomic, strong, readonly) XMAdImage *coverImage;

/// 组图
@property (nonatomic, strong, readonly, nullable) NSArray<XMAdImage *> *imageArr;

/// 广告类型
@property (nonatomic, assign, readonly) XMFeedADMode imageMode;

/// 视频试图，imageMode为image时，为空
@property (nonatomic, strong, readonly) UIView *videoView;

/// 如果是弹窗大图广告（动效云控），如果是其他nil  <这字段有ge毛用>
@property (nonatomic, copy, nullable) NSString *displayEffect_Style;

/// 是否有效
@property (nonatomic, assign, readonly) BOOL effective;

/// 是否是下载类
@property (nonatomic, assign, readonly) BOOL isAppAd;

/// 是否曝光
@property (nonatomic, assign, readonly) BOOL isExposure;

/// 委托
@property (nonatomic, weak) id <XMImgTextAdDelegate> adDelegate;

/// 广告基本信息
@property (nonatomic, strong, readonly) XMAdMaterialMeta *materialMeta;

/// 视频配置（default is null）
@property (nonatomic, strong) XMVideoConfig *videoConfig;

/// 广告角标
@property (nonatomic, strong, readonly) XMLogoImage *logoImage;

/// 此方法 会添加点击事件 且会自动监听containerView的进屏
/// @param containerView  adView容器视图
/// @param clickableViews 可以点击的视图， if empty will clickAble containerView，（注意，当为视频广告的时候，请不要将(大图封面)imageView传进来，或者将imageView隐藏掉）
/// @param vc             需传入用来弹出目标页的ViewController，一般为当前ViewController
- (void)registerAdContainer:(__kindof UIView *)containerView
             ableClickViews:(NSArray<__kindof UIView *> * _Nullable)clickableViews
                  presentVC:(UIViewController *)vc;

/// 移除containerView的进屏监听 & 移除点击事件<建议和上面的register方法成对使用>
/// tableView、collectionView等场景时，需要在合适的时机（如:cell的prepareForReuse）执行此方法，
- (void)unRegistAdContainer;

/// 刷新ad
- (void)refreshAdData;

@end

@protocol XMImgTextAdDelegate <NSObject>
@optional
/// 曝光回调
- (void)imgTextAdDidExposure:(XMImgTextAd *)ad;

/// 点击回调
- (void)imgTextAdDidClick:(XMImgTextAd *)ad;

/// 关闭详情页回调
- (void)imgTextAdDetailPageDidClose:(XMImgTextAd *)ad;

/// 视频加载，如果失败，可以调用refreshAdData，重新刷新
- (void)imgTextAdMediaLoadFinish:(XMImgTextAd *)ad error:(XMError *)error;

/// 视频播放状态
- (void)imgTextAdMediaPlaying:(XMImgTextAd *)ad playerStatusChanged:(XMAdMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo;

@end



NS_ASSUME_NONNULL_END

