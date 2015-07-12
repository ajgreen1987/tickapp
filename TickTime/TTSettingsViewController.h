//
//  TTSettingsViewController.h
//  TickTime
//
//  Created by AJ Green on 5/3/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"
#import "TTTimePickerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TTSettingsViewController : TTBaseViewController <UIActionSheetDelegate, TimePickerVCDelegate, MPMediaPickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UISwitch *facebook;
@property (weak, nonatomic) IBOutlet UISwitch *twitter;
@property (weak, nonatomic) IBOutlet UISwitch *music;
@property (weak, nonatomic) IBOutlet UISlider *timer;
@property (weak, nonatomic) IBOutlet UIButton *timePicker;

- (IBAction)handleTimeTouchUpInside:(id)sender;
- (IBAction)handleCountdownTimerValueChanged:(id)sender;
- (IBAction)handleMusicSwitchValueChanged:(id)sender;
- (IBAction)handleTwitterSwitchValueChanged:(id)sender;
- (IBAction)handleFacebookSwitchValueChanged:(id)sender;


@end

