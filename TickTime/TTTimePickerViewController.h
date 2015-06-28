//
//  TTTimePickerViewController.h
//  TickTime
//
//  Created by AJ Green on 6/27/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimePickerVCDelegate <NSObject>

- (void) didDismissWithTime:(NSDate*)aTime;

@end

@interface TTTimePickerViewController : UIViewController

- (IBAction)dismiss:(id)sender;
- (IBAction)dismissAndSave:(id)sender;

@property (nonatomic, weak) id<TimePickerVCDelegate> pickerDelegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@end
