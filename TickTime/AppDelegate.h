//
//  AppDelegate.h
//  TickTime
//
//  Created by AJ Green on 4/26/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) NSInteger countdownTimer;

+ (UIFont*) systemFontOfSize:(CGFloat)aSize;
+ (void) openURL:(NSURL*)aURL;

@end

