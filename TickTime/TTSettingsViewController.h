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

@interface TTSettingsViewController : TTBaseViewController <UIActionSheetDelegate, TimePickerVCDelegate>

- (IBAction)handleTimeTouchUpInside:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *timePicker;

@end

