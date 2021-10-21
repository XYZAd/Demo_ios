//
//  TableViewController.m
//  Demo
//
//  Created by C on 2020/9/1.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "UIImageView+YYWebImage.h"
#import "Masonry.h"

@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_feeds;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:UIScreen.mainScreen.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _feeds = [NSMutableArray new];
    for (int i = 0; i < 50; i ++) {
        XYZFeedCellModel *model = [XYZFeedCellModel new];
        if (i % 3 == 2) {
            model.feedType = XYZFeedType_Ad;
        } else {
            model.title = @"这是一个feed测试标题";
            model.mainImageUrl = @"https://t7.baidu.com/it/u=963301259,1982396977&fm=193&f=GIF";
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
            return 30 + model.ad.coverImage.imgHeight / radio;
        }
        return 0;
    }
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _feeds[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    XYZFeedCellModel *feedModel = [_feeds objectAtIndex:indexPath.row];
    if (feedModel.feedType == XYZFeedType_Ad && !feedModel.ad) {
        XMAdParam *para = [XMAdParam new];
        para.position = kDemoImgText;
        __weak __typeof(self) weakSelf = self;
        [XMImgTextAdProvider imgTextAdModelWithParam:para completion:^(XMImgTextAd * _Nullable model, XMError * _Nullable error) {
            __strong __typeof(weakSelf) this = weakSelf;
            if (model) {
                feedModel.ad = model;
                model.adDelegate = this;
                [this.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            }
        }];

    }
}

/// 曝光回调
- (void)imgTextAdDidExposure:(XMImgTextAd *)ad {
    NSLog(@"-------------%s",__func__);
}

/// 点击回调
- (void)imgTextAdDidClick:(XMImgTextAd *)ad {
    NSLog(@"-------------%s",__func__);
}

/// 关闭详情页回调
- (void)imgTextAdDetailPageDidClose:(XMImgTextAd *)ad {
    NSLog(@"-------------%s",__func__);
}

/// 视频加载失败
- (void)imgTextAdMediaLoadFailed:(XMImgTextAd *)ad error:(XMError *)error {
    NSLog(@"-------------%s",__func__);
}

@end
