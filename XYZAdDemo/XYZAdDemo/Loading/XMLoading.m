//
//  XMLoading.m
//  Demo
//
//  Created by C on 2021/7/8.
//  Copyright © 2021 大大东. All rights reserved.
//

#import "XMLoading.h"

static XMLoading *_loadView;

@interface XMLoading() {
    UIActivityIndicatorView *_acView;
}

@end


@implementation XMLoading

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
        [self setup];
    }
    return self;
}

- (void)setup {
    self.layer.cornerRadius = 5;
    _acView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:_acView];
    self.frame = CGRectMake(CGRectGetWidth(UIScreen.mainScreen.bounds) / 2 - 40, CGRectGetHeight(UIScreen.mainScreen.bounds) / 2 - 40, 80, 80);
    _acView.frame = CGRectMake(0, 0, 80, 80);
    _acView.contentMode = UIViewContentModeCenter;
}

+ (void)beginLoading {
    if (_loadView) {
        return;
    }
    _loadView = [XMLoading new];
    [_loadView->_acView startAnimating];
    UIWindow *win = [UIApplication sharedApplication].delegate.window;
    win.userInteractionEnabled = NO;
    [win addSubview:_loadView];
}

+ (void)endLoading {
    if (!_loadView) {
        return;
    }
    UIWindow *win = [UIApplication sharedApplication].delegate.window;
    [_loadView->_acView stopAnimating];
    [_loadView removeFromSuperview];
    _loadView = nil;
    win.userInteractionEnabled = YES;
}

@end
