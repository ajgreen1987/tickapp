//
//  TTTickCheckViewController.m
//  TickTime
//
//  Created by AJ Green on 5/4/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTTickCheckViewController.h"
#import "MZTimerLabel.h"
#import "AppDelegate.h"

@interface TTTickCheckViewController ()

@property (nonatomic, strong) UIImage *capturedImage;

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
    [[self view] addSubview:[self cancelButton]];
    [self setupTimerLabel];
    
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

- (UIButton*) cancelButton
{
    // snap button to capture image
    UIButton *snapButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    snapButton.frame = CGRectMake(self.view.frame.origin.x + 8.0f,
                                  self.view.frame.origin.y + 8.0f,
                                  70.0f,
                                  44.0f);
    snapButton.clipsToBounds = YES;
    [snapButton setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
    [snapButton setTitle:@"Cancel"
                forState:UIControlStateNormal];
    [snapButton addTarget:self
                   action:@selector(cancelTouched:)
         forControlEvents:UIControlEventTouchUpInside];
    
    return snapButton;
}

- (void)snapButtonPressed:(UIButton *)button
{

    __block TTTickCheckViewController *blockSafeSelf = self;
    
    // capture
    [self capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
        if(!error) {
            
            // we should stop the camera, since we don't need it anymore. We will open a new vc.
            // this very important, otherwise you may experience memory crashes
            [camera stop];
            
            // show the image
            [blockSafeSelf setCapturedImage:image];
            
            [blockSafeSelf performSegueWithIdentifier:@"Preview"
                                               sender:self];

        }
        else {
            NSLog(@"An error has occured: %@", error);
        }
    } exactSeenImage:YES];
}

- (void) cancelTouched:(UIButton*) button
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void) setupTimerLabel
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100.0f,
                                                               self.view.frame.size.height - (40.0f+(40.0f*0.5f)),
                                                               100.0f,
                                                               40.0f)];
    [label setTextColor:[UIColor whiteColor]];
    [[self view] addSubview:label];
    
    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:label
                                                 andTimerType:MZTimerLabelTypeTimer];
    [timer setCountDownTime:appDelegate.countdownTimer];
    [timer start];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"Preview"])
    {
        
    }
 }


@end
