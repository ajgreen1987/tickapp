//
//  TTResourcesViewController.m
//  TickTime
//
//  Created by AJ Green on 5/3/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTResourcesViewController.h"
#import "AppDelegate.h"

@interface TTResourcesViewController ()

@end

@implementation TTResourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleCDCTouchUpInside:(id)sender
{
    [AppDelegate openURL:[NSURL URLWithString:@"http://www.cdc.gov/ticks/"]];
}

- (IBAction)handleTickProductsTouchUpInside:(id)sender
{
    [AppDelegate openURL:[NSURL URLWithString:@"http://www.amazon.com/gp/aw/s/ref=is_s_ss_i_0_5?k=tick+repellent&sprefix=Tick+"]];
}

- (IBAction)handleTickFactsTouchUpInside:(id)sender
{
    [AppDelegate openURL:[NSURL URLWithString:@"https://en.m.wikipedia.org/wiki/Tick"]];
}

@end
