//
//  BulletScreenManager.m
//  Demo
//
//  Created by C on 2021/12/1.
//  Copyright © 2021 大大东. All rights reserved.
//

#import "BulletScreenManager.h"
#import "Masonry.h"


@interface BulletWindow : UIWindow

@end

@implementation BulletWindow

+ (BulletWindow *)createBulletWindow {
    BulletWindow *window = [[BulletWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.windowLevel = UIWindowLevelAlert + 1000;
    window.rootViewController = [UIViewController new];
    window.userInteractionEnabled = YES;
    window.hidden = NO;
    return window;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return nil;
}

@end

@interface BulletScreenManager()

@property (nonatomic, assign) BOOL hasInstall;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSLock *lock;

@property (nonatomic, strong) NSMutableArray *textArray;

@property (nonatomic, strong) NSMutableArray *showTextArray;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) BulletWindow *bulletWindow;

@end

@implementation BulletScreenManager

+ (instancetype)sharedInstance {
    static BulletScreenManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[self alloc] init];
    });
    return m;
}

- (instancetype)init {
    if (self = [super init]) {
        _contentView = [UIView new];
        _contentView.userInteractionEnabled = NO;
    }
    return self;
}

+ (void)install {
    BulletScreenManager *m = [BulletScreenManager sharedInstance];
    if (m.hasInstall) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        BulletWindow *wind = [BulletWindow createBulletWindow];
        m.bulletWindow = wind;
        [wind addSubview:m.contentView];
        m.hasInstall = YES;
        [m.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@64);
            make.height.equalTo(m.contentView.superview.mas_height).multipliedBy(0.3);
        }];
    });
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 14)];
    label.text = text;
    label.layer.borderColor = [UIColor greenColor].CGColor;
    label.textColor = [UIColor blueColor];
    label.layer.borderWidth = 0.5;
    return label;
}

- (void)showWithText:(NSString *)text {
    if (text.length == 0) {
        return;
    }
    [BulletScreenManager install];
    __weak typeof(self) weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [weakSelf _showWithText:text];
    }];
}

- (void)_showWithText:(NSString *)text {
    [self.contentView.superview bringSubviewToFront:self.contentView];
    UILabel *label = [self labelWithText:text];
    [label sizeToFit];
    CGFloat labelHeight = label.frame.size.height;
    [self.contentView addSubview:label];
    __block MASConstraint *leftConstraint = nil;
    CGFloat width = [UIApplication sharedApplication].delegate.window.bounds.size.width;
    NSInteger currentIndex = [self currentIndex];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(currentIndex * (labelHeight + 5)));
        make.height.equalTo(@(labelHeight));
        leftConstraint = make.left.equalTo(@(width));
    }];
    [self.contentView layoutIfNeeded];
    [self increamIndex];
    NSTimeInterval druation = MAX(4, 3 * (width + label.frame.size.width) / width);
    [UIView animateWithDuration:druation animations:^{
        // 设置动画约束
        leftConstraint.equalTo(@(-label.frame.size.width));
        [self.contentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
        [self decreamIndex];
    }];
}

- (void)increamIndex {
    [self.lock lock];
    self.index++;
    [self.lock unlock];
}

- (void)decreamIndex {
    [self.lock lock];
    self.index--;
    [self.lock unlock];
}

- (NSInteger)currentIndex {
    NSInteger resultIndex = 0;
    [self.lock lock];
    resultIndex = self.index;
    [self.lock unlock];
    return resultIndex;
}


@end
