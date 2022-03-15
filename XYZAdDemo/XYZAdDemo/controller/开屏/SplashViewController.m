//
//  SplashViewController.m
//  Demo
//
//  Created by C on 2020/6/24.
//  Copyright © 2020 大大东. All rights reserved.
//

#import "SplashViewController.h"
#import "SplashHelper.h"

@interface SplashViewController () {
    CGSize _size;

    
}
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation SplashViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.messageLabel.hidden = YES;
    _size = UIScreen.mainScreen.bounds.size;
    
}

- (IBAction)fullscreen:(id)sender {
    _size = UIScreen.mainScreen.bounds.size;
}

- (IBAction)middlescreen:(id)sender {
    _size = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds) / 10 * 8);
}

- (IBAction)splash:(id)sender {
    [[SplashHelper sharedInstance] loadSplashWithSize:_size];
}

@end
