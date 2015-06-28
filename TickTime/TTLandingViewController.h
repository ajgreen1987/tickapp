//
//  ViewController.h
//  TickTime
//
//  Created by AJ Green on 4/26/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTLandingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *animatedBackground;
@property (weak, nonatomic) IBOutlet UIButton *doACheck;
@property (weak, nonatomic) IBOutlet UIButton *instructions;
@property (weak, nonatomic) IBOutlet UIButton *resources;
@property (weak, nonatomic) IBOutlet UIButton *settings;
@property (weak, nonatomic) IBOutlet UIButton *savedImages;
@property (weak, nonatomic) IBOutlet UIButton *facebook;
@property (weak, nonatomic) IBOutlet UIButton *twitter;

- (IBAction)handleFacebookTouchUpInside:(id)sender;
- (IBAction)handleTwitterTouchUpInside:(id)sender;
@end

