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
    [AppDelegate openURL:[NSURL URLWithString:@"http://www.cdc.gov/ticks/removing_a_tick.html"]];
}

- (IBAction)handleTickProductsTouchUpInside:(id)sender
{
    [AppDelegate openURL:[NSURL URLWithString:@"http://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=tick+removal&rh=i%3Aaps%2Ck%3Atick+removal"]];
}

- (IBAction)handleTickFactsTouchUpInside:(id)sender
{
    [AppDelegate openURL:[NSURL URLWithString:@"http://www.tickencounter.org"]];
}

@end
