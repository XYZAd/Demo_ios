//
//  DrawVideoViewController.m
//  Demo
//
//  Created by C on 2020/7/3.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "DrawVideoViewController.h"
#import "Masonry.h"


@interface DrawVideoViewController () {
    XMDrawVideoAd *_drawVideo;
    UILabel *_textLabel;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation DrawVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.messageLabel.text = @"";
    _textLabel = [UILabel new];
    _textLabel.textColor = UIColor.whiteColor;
    [self.view addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(@(-100));
        make.left.equalTo(@50);
        make.right.equalTo(@(-50));
    }];
    
}
- (IBAction)show:(id)sender {
    if (_drawVideo) {
        if (_drawVideo.imageMode == XMFeedADMode_VideoImage) {
            _drawVideo.drawVideoClickEnable = YES;
            [self.view addSubview:_drawVideo.videoView];
            [_drawVideo.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
            [self.view bringSubviewToFront:_textLabel];
        }
        _textLabel.text = _drawVideo.adTitle;
        [_drawVideo registerAdContainer:self.view ableClickViews:@[_textLabel] presentVC:self];
        self.messageLabel.text = @"展示成功";
    }
}

- (IBAction)load:(id)sender {
    NSLog(@"begin load %ld",time(NULL));
    BeginLoading
    XMAdParam *param = [XMAdParam new];
    param.position = kDemoDraw;
    [XMDrawVideoAdProvider drawVideoAdModelWithParam:param completion:^(XMDrawVideoAd * _Nullable model, XMError * _Nullable error) {
        EndLoading
        NSLog(@"end load %ld",time(NULL));
        self.messageLabel.text = !error ? @"加载成功" : @"加载失败";
        self->_drawVideo = model;
    }];
}


@end

