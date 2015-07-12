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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    [self.timePicker setTitle:[formatter stringFromDate:aTime]
                     forState:UIControlStateNormal];
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
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
