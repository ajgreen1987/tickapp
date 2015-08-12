//
//  TTSettingsViewController.m
//  TickTime
//
//  Created by AJ Green on 5/3/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTSettingsViewController.h"
#import "AppDelegate.h"

@interface TTSettingsViewController ()

@end

@implementation TTSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupFromDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupFromDefaults
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [self.facebook setOn:[appDelegate shouldShowFacebook]];
    [self.twitter setOn:[appDelegate shouldShowTwitter]];
    [self.music setOn:([appDelegate songURL] != nil)];
    
    NSString *time = [self formattedDate:appDelegate.notificationDate];
    
    [self.timePicker setTitle:(time == nil) ? [self formattedDate:[NSDate date]] : time
                     forState:UIControlStateNormal];
}

- (IBAction)handleTimeTouchUpInside:(id)sender
{
    TTTimePickerViewController *timePickerViewController = (TTTimePickerViewController*)[self.storyboard   instantiateViewControllerWithIdentifier:@"TimePicker"];
    [timePickerViewController setPickerDelegate:self];
    timePickerViewController.providesPresentationContextTransitionStyle = YES;
    timePickerViewController.definesPresentationContext = YES;
    [timePickerViewController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self.navigationController presentViewController:timePickerViewController animated:YES completion:nil];
    
}

#pragma mark - Picker Delegate
- (void) didDismissWithTime:(NSDate *)aTime
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate setNotificationDate:aTime];
    [self scheduleNotificationForTime:aTime];
    
    [self.timePicker setTitle:[self formattedDate:aTime]
                     forState:UIControlStateNormal];
}

- (void) scheduleNotificationForTime:(NSDate*)aTime
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = aTime;
    notification.alertBody = @"TickTime Reminder!";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 1;
    notification.repeatInterval = kCFCalendarUnitDay;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (IBAction)handleCountdownTimerValueChanged:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    NSInteger value = slider.value;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate setCountdownTimer:value];
}

- (IBAction)handleMusicSwitchValueChanged:(id)sender
{
    UISwitch *music = (UISwitch*)sender;
    BOOL isOn = music.isOn;
    
    if (isOn)
    {
        MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeAny];
        
        mediaPicker.delegate = self;
        mediaPicker.allowsPickingMultipleItems = YES;
        mediaPicker.prompt = @"Select your TickTime Song";
        
        [self presentViewController:mediaPicker animated:YES completion:^{
            
        }];
    }
    else
    {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        [appDelegate setSongURL:nil];
    }
    
}

- (IBAction)handleTwitterSwitchValueChanged:(id)sender
{
    UISwitch *twitter = (UISwitch*)sender;
    BOOL isOn = twitter.isOn;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate setShouldShowTwitter:isOn];
}

- (IBAction)handleFacebookSwitchValueChanged:(id)sender
{
    UISwitch *facebook = (UISwitch*)sender;
    BOOL isOn = facebook.isOn;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate setShouldShowFacebook:isOn];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    if (mediaItemCollection)
    {
        MPMediaItem *item = [[mediaItemCollection items] objectAtIndex:0];
        NSURL *url = [item valueForProperty:MPMediaItemPropertyAssetURL];
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate setSongURL:url];
        
        [mediaPicker dismissViewControllerAnimated:YES completion:^{
        }];
    }
    

}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (NSString*) formattedDate:(NSDate*)aDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    return [formatter stringFromDate:aDate];
}

@end
