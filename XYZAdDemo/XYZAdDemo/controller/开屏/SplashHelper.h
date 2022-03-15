//
//  SplashHelper.h
//  Demo
//
//  Created by C on 2022/2/24.
//  Copyright © 2022 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SplashHelper : NSObject


@property (nonatomic, strong) XMSplashAdProvider *splashProvider;

+ (instancetype)sharedInstance;

- (void)loadSplashWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
