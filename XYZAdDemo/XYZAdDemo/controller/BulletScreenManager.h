//
//  BulletScreenManager.h
//  Demo
//
//  Created by C on 2021/12/1.
//  Copyright © 2021 大大东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BulletScreenManager : NSObject

+ (instancetype)sharedInstance;

- (void)showWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
