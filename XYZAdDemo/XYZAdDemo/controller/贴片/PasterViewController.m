//
//  PasterViewController.m
//  Demo
//
//  Created by C on 2022/2/7.
//  Copyright © 2022 大大东. All rights reserved.
//

#import "PasterViewController.h"
#import <AVKit/AVKit.h>


@interface PasterView : UIView {
    UIImageView *_coverImageView;
    NSTimer *_timer;
    UILabel *_skipLabel;
    XMImgTextAd *_pasterAdModel;
    int _timeInterval;
}

@property (nonatomic, copy) void (^ pasterEndBlock)(void);

@property (nonatomic, weak) UIViewController *vc;

@end

@implementation PasterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _coverImageView = [UIImageView new];
    [self addSubview:_coverImageView];
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIView *skipView = [UIView new];
    skipView.layer.masksToBounds = YES;
    skipView.layer.cornerRadius = 5;
    skipView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    [self addSubview:skipView];
    [skipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.right.equalTo(@-10);
    }];
    _skipLabel = [UILabel new];
    [skipView addSubview:_skipLabel];
    _skipLabel.userInteractionEnabled = NO;
    [_skipLabel addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skipGesture)];
        tap;
    })];
    _skipLabel.textColor = UIColor.whiteColor;
    [_skipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
    
}

- (void)setPasterAdModel:(XMImgTextAd *)adModel {
    _pasterAdModel = adModel;
    if (_pasterAdModel.materialMeta.imgTextRenderType == XMImgTextRenderTypeExpress) {
        [_coverImageView addSubview:_pasterAdModel.materialMeta.expressView];
        [_pasterAdModel.materialMeta.expressView renderAdIfNeed];
        _timeInterval = MAX(5, [_pasterAdModel.materialMeta.expressView duration]);
        [_pasterAdModel.materialMeta.expressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    } else {
        [_coverImageView yy_setImageWithURL:[NSURL URLWithString:_pasterAdModel.materialMeta.coverImage.imgURL] options:0];
        _timeInterval = MAX(5, (int)[_pasterAdModel.materialMeta.videoView videoDuration]);
        if (_pasterAdModel.materialMeta.imageMode == XMFeedADMode_VideoImage) {
            [_coverImageView addSubview:_pasterAdModel.materialMeta.videoView];
            [_pasterAdModel.materialMeta.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsZero);
            }];
        }
        [_pasterAdModel registerAdContainer:_coverImageView ableClickViews:nil presentVC:self.vc];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    _skipLabel.text = [NSString stringWithFormat:@"%d可跳过",_timeInterval];
    
}

- (void)skipGesture {
    XM_BLOCK_EXEC(self.pasterEndBlock);
    [self removeFromSuperview];
}

- (void)timerAction {
    _timeInterval --;
    if (_timeInterval <= 0) {
        [_timer invalidate];
        _timer = nil;
        _skipLabel.text = @"跳过";
        _skipLabel.userInteractionEnabled = YES;
        return;
    }
    _skipLabel.text = [NSString stringWithFormat:@"%d可跳过",_timeInterval];
}

@end




@interface PasterViewController () {
    AVPlayer *_player;
    AVPlayerLayer *_playLayer;
    PasterView *_pasterView;
}

@end

@implementation PasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1644199624699079" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    
    AVPlayerItem *playItem = [[AVPlayerItem alloc] initWithURL:url];
    _player = [[AVPlayer alloc] initWithPlayerItem:playItem];
    
    _playLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playLayer.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 200);
    _playLayer.contentsGravity = kCAGravityResizeAspectFill;
    [self.view.layer addSublayer:_playLayer];
    [self loadPasterAd];
}

- (void)loadPasterAd {
    XMAdImgTextParam *param = [[XMAdImgTextParam alloc] init];
    param.position = kDemoPaster;
    param.gametypeID = @"test";
    param.adPositionAdType = XMAdPositionAdTypePaster;
    param.expectAdSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width * 2, 200 * 2);
    
    BeginLoading;
    [XMImgTextAdProvider imgTextAdModelWithParam:param completion:^(XMImgTextAd * _Nullable model, XMError * _Nullable error) {
        EndLoading;
        [self tryShowPasterAd:model];
    }];
}

- (void)tryShowPasterAd:(XMImgTextAd *)ad {
    if (!ad) {
        [_player play];
        return;
    }
    ad.materialMeta.expressView.rootViewController = self;
    _pasterView = [PasterView new];
    _pasterView.vc = self;
    _pasterView.pasterEndBlock = ^{
        [_player play];
    };
    [_pasterView setPasterAdModel:ad];
    [self.view addSubview:_pasterView];
    [_pasterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@100);
        make.height.mas_equalTo(200);
    }];
    
}






@end
