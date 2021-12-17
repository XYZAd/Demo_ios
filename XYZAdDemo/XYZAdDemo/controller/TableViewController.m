//
//  TableViewController.m
//  Demo
//
//  Created by C on 2020/9/1.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "TableViewController.h"
#import "AdTableViewCell.h"
#import "Masonry.h"

@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource, XMImgTextAdDelegate> {
    NSMutableArray *_feeds;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:UIScreen.mainScreen.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
//    [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
//    [_tableView registerClass:[AdTableViewCell class] forCellReuseIdentifier:@"adcell"];
    _feeds = [NSMutableArray new];
    for (int i = 0; i < 50; i ++) {
        XYZFeedCellModel *model = [XYZFeedCellModel new];
        model.title = [NSString stringWithFormat:@"%d 这是一个feed测试标题",i];
        model.mainImageUrl = @"https://t7.baidu.com/it/u=963301259,1982396977&fm=193&f=GIF";
        if (i % 5 == 2) {
            model.feedType = XYZFeedType_Ad;
            XMAdParam *para = [XMAdParam new];
            para.position = kDemoImgText;
            __weak __typeof(self) weakSelf = self;
            model.loadingState = XYZLoadingState_Reqing;
            [XMImgTextAdProvider imgTextAdModelWithParam:para completion:^(XMImgTextAd * _Nullable ad, XMError * _Nullable error) {
                __strong __typeof(weakSelf) this = weakSelf;
                if (ad) {
                    model.ad = ad;
                    ad.adDelegate = this;
                    
                    NSIndexPath *beginIndxP = [this.tableView indexPathForCell:this.tableView.visibleCells.firstObject];
                    
                    NSIndexPath *lastIndxP = [this.tableView indexPathForCell:this.tableView.visibleCells.lastObject];
                    if (i >= beginIndxP.row && i <= lastIndxP.row) {
                        [this.tableView beginUpdates];
                        [this.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                        
                        [this.tableView endUpdates];
                    }
                    
                    model.loadingState = XYZLoadingState_End;
                } else {
                    model.loadingState = XYZLoadingState_Idle;
                }
                
            }];
        }
        [_feeds addObject:model];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _feeds.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYZFeedCellModel *model = _feeds[indexPath.row];
    if (model.feedType == XYZFeedType_Ad) {
        if (model.ad) {
            CGFloat radio = model.ad.coverImage.imgWidth / CGRectGetWidth(UIScreen.mainScreen.bounds);
            return 30 + model.ad.coverImage.imgHeight / MAX(1, radio);
        }
        return CGFLOAT_MIN;
    }
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYZFeedCellModel *model = _feeds[indexPath.row];
    NSString *identifier = @"cell";
    Class class = TableViewCell.class;
    if (model.feedType == XYZFeedType_Ad) {
        if (model.ad.imageMode == XMFeedAdMode_Text) {
            identifier = @"textcell";
            class = AdTextCell.class;
        } else {
            identifier = @"adcell";
            class = AdTableViewCell.class;
        }
    }
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    XYZFeedCellModel *feedModel = [_feeds objectAtIndex:indexPath.row];
    if (feedModel.feedType == XYZFeedType_Ad && !feedModel.ad && feedModel.loadingState == XYZLoadingState_Idle) {
        

    }
}

/// 曝光回调
- (void)imgTextAdDidExposure:(XMImgTextAd *)ad {
    NSLog(@"-------------%s",__func__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,曝光",__func__]];
}

/// 点击回调
- (void)imgTextAdDidClick:(XMImgTextAd *)ad {
    NSLog(@"-------------%s",__func__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,点击",__func__]];
}

/// 关闭详情页回调
- (void)imgTextAdDetailPageDidClose:(XMImgTextAd *)ad {
    NSLog(@"-------------%s",__func__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,详情页关闭",__func__]];
}

/// 视频加载失败
- (void)imgTextAdMediaLoadFailed:(XMImgTextAd *)ad error:(XMError *)error {
    NSLog(@"-------------%s",__func__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,视频加载失败",__func__]];
}

- (void)imgTextAdMediaPlaying:(XMImgTextAd *)ad playerStatusChanged:(XMAdMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo {
    NSLog(@"-------------%s",__func__);
    [[BulletScreenManager sharedInstance] showWithText:[NSString stringWithFormat:@"%s,视频播放状态改变",__func__]];
}


@end
