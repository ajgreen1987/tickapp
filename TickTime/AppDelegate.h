//
//  AppDelegate.h
//  TickTime
//
//  Created by AJ Green on 4/26/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) NSInteger countdownTimer;
@property (nonatomic, assign) BOOL shouldShowFacebook;
@property (nonatomic, assign) BOOL shouldShowTwitter;
@property (nonatomic, strong) NSURL *songURL;

+ (UIFont*) systemFontOfSize:(CGFloat)aSize;
+ (void) openURL:(NSURL*)aURL;
+ (void) writeBool:(BOOL)aBooleanValue forKey:(NSString*)aKey;
+ (void) writeString:(NSString*)aStringValue forKey:(NSString*)aKey;
+ (BOOL) readBoolForKey:(NSString*)aKey;
+ (NSString*) readStringForKey:(NSString*)aKey;

@end

