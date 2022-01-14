//
//  ViewController.m
//  XYZAdDemo
//
//  Created by C on 2021/8/27.
//


#import "ViewController.h"
#import "SplashViewController.h"
#import "ImageTextViewController.h"
#import "BannerViewController.h"
#import "VideoViewController.h"
#import "XMIntersititialAdViewController.h"
#import "DrawVideoViewController.h"
#import "TableViewController.h"
#import "ExpressDrawViewController.h"
#import "ExpressImgTextViewController.h"
#import "FullScreenViewController.h"
#import "NativeInterisititialViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray <NSString *> *_titles;
    NSArray <NSString *> *_controllerClass;
    XMVideoAd *_videoAd;
    NSInteger _temp;
    

}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"XMADSDK_ver %@",[XMAdMain sdkVersion]];
    
    _titles = @[@"开屏",@"图文",@"模版图文",@"激励视频",@"全屏视频",@"轮播广告",@"插屏广告",@"自渲染插屏",@"自渲染draw",@"模版draw",@"信息流"];
    _controllerClass = @[NSStringFromClass(SplashViewController.class),NSStringFromClass(ImageTextViewController.class),@"ExpressImgTextViewController",NSStringFromClass(VideoViewController.class),@"FullScreenViewController",NSStringFromClass(BannerViewController.class),NSStringFromClass(XMIntersititialAdViewController.class),NSStringFromClass(NativeInterisititialViewController.class),NSStringFromClass(DrawVideoViewController.class),NSStringFromClass(ExpressDrawViewController.class),NSStringFromClass(TableViewController.class)];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[NSClassFromString(_controllerClass[indexPath.row]) alloc] init];
    if (vc) {
        vc.navigationItem.title = _titles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

@end

