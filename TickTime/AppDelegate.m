//
//  AppDelegate.m
//  TickTime
//
//  Created by AJ Green on 4/26/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "AppDelegate.h"

#define FACEBOOK        @"FB"
#define TWITTER         @"Twitter"
#define SONG            @"URL"
#define TIMER           @"Timer"
#define NOTIFICATION    @"Notify"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    // Hide Status Bar
    [application setStatusBarHidden:YES];
    
    [self setCountdownTimer:60];

    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName:[AppDelegate systemFontOfSize:12.0f]}
                                                   forState:UIControlStateNormal];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Settings
- (void) setShouldShowFacebook:(BOOL)shouldShowFacebook
{
    [AppDelegate writeBool:shouldShowFacebook forKey:FACEBOOK];
}

- (void) setShouldShowTwitter:(BOOL)shouldShowTwitter
{
    [AppDelegate writeBool:shouldShowTwitter forKey:TWITTER];
}

- (BOOL) shouldShowFacebook
{
    return [AppDelegate readBoolForKey:FACEBOOK];
}

- (BOOL) shouldShowTwitter
{
    return [AppDelegate readBoolForKey:TWITTER];
}

- (void) setSongURL:(NSURL *)songURL
{
    [AppDelegate writeString:[songURL absoluteString] forKey:SONG];
}

- (NSURL*) songURL
{
    return [NSURL URLWithString:[AppDelegate readStringForKey:SONG]];
}

- (void) setCountdownTimer:(NSInteger)countdownTimer
{
    [AppDelegate writeInteger:countdownTimer forKey:TIMER];
}

- (NSInteger) countdownTimer
{
    NSInteger toReturn = [AppDelegate readIntegerForKey:TIMER];
    
    return toReturn;
}

- (void) setNotificationDate:(NSDate *)notificationDate
{
    [AppDelegate writeObject:notificationDate
                      forKey:NOTIFICATION];
}

- (NSDate*) notificationDate
{
    NSDate *toReturn = [AppDelegate readObjectForKey:NOTIFICATION];
    
    return toReturn;
}


#pragma mark - Font Helpers

+ (UIFont*) systemFontOfSize:(CGFloat)aSize
{
    return [UIFont fontWithName:@"Quicksand-Light"
                           size:aSize];
}

+ (void) openURL:(NSURL *)aURL
{
    if ([[UIApplication sharedApplication] canOpenURL:aURL])
    {
        [[UIApplication sharedApplication] openURL:aURL];
    }
}

#pragma mark - NSUserDefaults

+ (void) writeBool:(BOOL)aBooleanValue forKey:(NSString*)aKey
{
    [[NSUserDefaults standardUserDefaults] setBool:aBooleanValue
                                            forKey:aKey];
}

+ (void) writeString:(NSString*)aStringValue forKey:(NSString*)aKey
{
    [[NSUserDefaults standardUserDefaults] setValue:aStringValue
                                             forKey:aKey];
}

+ (void) writeInteger:(NSInteger)anInteger forKey:(NSString *)aKey
{
    [[NSUserDefaults standardUserDefaults] setInteger:anInteger forKey:aKey];
}

+ (void) writeObject:(id)object forKey:(NSString*)aKey
{
    [[NSUserDefaults standardUserDefaults] setObject:object
                                              forKey:aKey];
}

+ (BOOL) readBoolForKey:(NSString*)aKey
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:aKey];
}

+ (NSString*) readStringForKey:(NSString*)aKey
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:aKey];
}

+ (NSInteger) readIntegerForKey:(NSString *)aKey
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:aKey];
}

+ (id) readObjectForKey:(NSString*)aKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:aKey];
}

@end
