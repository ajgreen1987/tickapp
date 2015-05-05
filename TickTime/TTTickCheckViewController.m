//
//  TTTickCheckViewController.m
//  TickTime
//
//  Created by AJ Green on 5/4/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTTickCheckViewController.h"

@interface TTTickCheckViewController ()

@end

@implementation TTTickCheckViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithQuality:CameraQualityHigh andPosition:CameraPositionBack];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self start];
}

- (void) viewDidAppear:(BOOL)animated
{
    [[self view] addSubview:[self snapButton]];
    
    [self turnOnTorch];
}

- (void) turnOnTorch
{
    if ([self.captureDevice hasTorch])
    {
        [self.captureDevice lockForConfiguration:nil];
        [self.captureDevice setTorchMode:AVCaptureTorchModeOn];  // use AVCaptureTorchModeOff to turn off
        [self.captureDevice unlockForConfiguration];
    }
}

- (UIButton*) snapButton
{
    // snap button to capture image
    UIButton *snapButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    snapButton.frame = CGRectMake(self.view.center.x-(70.0f*0.5f), self.view.frame.size.height - (70.0f+(70.0f*0.5f)), 70.0f, 70.0f);
    snapButton.clipsToBounds = YES;
    snapButton.layer.cornerRadius = snapButton.frame.size.width / 2.0f;
    snapButton.layer.borderColor = [UIColor whiteColor].CGColor;
    snapButton.layer.borderWidth = 2.0f;
    snapButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    snapButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
    snapButton.layer.shouldRasterize = YES;
    [snapButton addTarget:self
                   action:@selector(snapButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    
    return snapButton;
}

- (void)snapButtonPressed:(UIButton *)button {
    
    // capture
    [self capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
        if(!error) {
            
            // we should stop the camera, since we don't need it anymore. We will open a new vc.
            // this very important, otherwise you may experience memory crashes
            [camera stop];
            
            // show the image

        }
        else {
            NSLog(@"An error has occured: %@", error);
        }
    } exactSeenImage:YES];
}


@end
