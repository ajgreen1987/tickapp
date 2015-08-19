//
//  TTTimePickerViewController.m
//  TickTime
//
//  Created by AJ Green on 6/27/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTTimePickerViewController.h"

@interface TTTimePickerViewController ()

@end

@implementation TTTimePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)dismissAndSave:(id)sender
{
    [[self pickerDelegate] didDismissWithTime:self.timePicker.date];
    [self dismiss:nil];    
}
@end
