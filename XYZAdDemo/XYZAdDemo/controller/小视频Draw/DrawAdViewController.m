//
//  ExpressImgTextViewController.m
//  Demo
//
//  Created by C on 2021/3/24.
//  Copyright © 2021 大大东. All rights reserved.
//

#import "DrawAdViewController.h"
#import "ImgTextCollectionViewCell.h"


@interface DrawAdViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, XMImgTextAdDelegate> {
    UICollectionView *_collectionView;
    NSMutableArray <XMImgTextAd *>*_adsArray;
}

@end

@implementation DrawAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    _adsArray = [NSMutableArray new];
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds) * 2, (CGRectGetHeight(UIScreen.mainScreen.bounds) - 64 - (demo_isBangScreen() ? 24 : 0) * 2));
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.delegate = self;
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64 + (demo_isBangScreen() ? 24 : 0), 0, 0, 0));
    }];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"ImgTextCollectionViewCell" bundle:NSBundle.mainBundle] forCellWithReuseIdentifier:@"cell"];
    [self loadAd:0];
    
       
}

- (void)loadAd:(int)count {
    if (count > 3) {
        return;
    }
    count ++;
    XMAdImgTextParam *imgParam = [XMAdImgTextParam new];
    imgParam.position = kDemoDraw;
    imgParam.adPositionAdType = XMAdPositionAdTypeDraw;
    imgParam.expectAdSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds) * 2, (CGRectGetHeight(UIScreen.mainScreen.bounds) - 64 - (demo_isBangScreen() ? 24 : 0) * 2));
    [XMImgTextAdProvider imgTextAdModelWithParam:imgParam completion:^(XMImgTextAd * _Nullable model, XMError * _Nullable error) {
        if (model) {
            model.adDelegate = self;
            [_adsArray addObject:model];
            [_collectionView reloadData];
        }
        [self loadAd:count];
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _adsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImgTextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.adModel = _adsArray[indexPath.item];
    cell.controller = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_adsArray.count - indexPath.item <= 2) {
        XMAdImgTextParam *imgParam = [XMAdImgTextParam new];
        imgParam.position = kDemoDraw;
        imgParam.adPositionAdType = XMAdPositionAdTypeDraw;
        imgParam.expectAdSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds) * 2, (CGRectGetHeight(UIScreen.mainScreen.bounds) - 64 - (demo_isBangScreen() ? 24 : 0)) * 2);
        [XMImgTextAdProvider imgTextAdModelWithParam:imgParam completion:^(XMImgTextAd * _Nullable model, XMError * _Nullable error) {
            if (model) {
                model.adDelegate = self;
                [_adsArray addObject:model];
                [_collectionView reloadData];
            }
        }];
    }
}

- (void)imgTextShowFailed:(XMImgTextAd *)ad error:(XMError *)error {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,渲染失败",__func__]];
}

- (void)imgTextAdDidExposure:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

- (void)imgTextAdDidClick:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

- (void)imgTextAdDetailPageDidClose:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,详情页关闭",__func__]];
}

/// 关闭广告（模版广告才走这个代理）
- (void)imgTextAdDidClose:(XMImgTextAd *)ad {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,广告关闭",__func__]];
}

/// 视频加载，如果失败，可以调用refreshAdData，重新刷新
- (void)imgTextAdMediaLoadFinish:(XMImgTextAd *)ad error:(XMError *)error {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,视频加载",__func__]];
}

/// 视频播放状态
- (void)imgTextAdMediaPlaying:(XMImgTextAd *)ad playerStatusChanged:(XMAdMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo {
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,视频播放状态",__func__]];
}


@end
