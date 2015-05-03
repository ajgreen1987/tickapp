//
//  TTBaseViewController.m
//  TickTime
//
//  Created by AJ Green on 5/3/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTBaseViewController.h"

@interface TTBaseViewController ()

@end

@implementation TTBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self view] addSubview:[self bottomHomeButton]];
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

/**
 This method creates a button and places it at the bottom center of the page. It's singular purpose is to pop the navigation controller to root. If there is no navigation controller then this method is useless.
 */
- (UIButton*) bottomHomeButton
{
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSString *homeTitle = @"Home";
    CGFloat xOrigin = 0.0f;
    CGFloat yOrigin = 0.0f;
    CGFloat height = 44.0f;
    CGFloat width = 140.0f;
    CGFloat selfViewHeight = self.view.frame.size.height;

    [home setBackgroundColor:[UIColor colorWithRed:(247.0f/255.0f)
                                             green:(143.0f/255.0f)
                                              blue:0.0f
                                             alpha:1.0f]];
    
    [home setTitle:homeTitle forState:UIControlStateNormal];
    [home setFrame:CGRectMake(xOrigin, yOrigin, width, height)];
    [home setCenter:CGPointMake(self.view.center.x, (selfViewHeight - height))];
    
    if (self.navigationController != nil)
    {
        [home addTarget:self.navigationController
                 action:@selector(popToRootViewControllerAnimated:)
       forControlEvents:UIControlEventTouchUpInside];
    }
    
    return home;
}

@end
