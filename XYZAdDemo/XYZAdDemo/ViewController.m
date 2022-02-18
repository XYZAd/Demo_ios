//
//  ViewController.m
//  XYZAdDemo
//
//  Created by C on 2021/8/27.
//


#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray <NSString *> *_titles;
    NSArray <NSString *> *_controllerClass;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"XMADSDK_ver %@",[XMAdMain sdkVersion]];
    
    _titles = @[@"开屏",@"图文",@"Draw广告",@"贴片",@"激励视频",@"全屏视频",@"轮播广告",@"插屏广告",@"自渲染插屏",@"信息流"];
    _controllerClass = @[@"SplashViewController",
                         @"ImageTextViewController",
                         @"DrawAdViewController",
                         @"PasterViewController",
                         @"VideoViewController",
                         @"FullScreenViewController",
                         @"BannerViewController",
                         @"XMIntersititialAdViewController",
                         @"NativeInterisititialViewController",
                         @"TableViewController"];
    
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

