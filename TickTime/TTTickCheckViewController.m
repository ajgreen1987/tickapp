//
//  TTTickCheckViewController.m
//  TickTime
//
//  Created by AJ Green on 5/4/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTTickCheckViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TTImagePreviewViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@interface TTTickCheckViewController ()

@property (nonatomic, strong) UIImage *capturedImage;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, assign) BOOL isFirstTime;

@end

@implementation TTTickCheckViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithQuality:CameraQualityHigh andPosition:CameraPositionBack];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupCountdown];
}

- (void) viewDidAppear:(BOOL)animated
{
    if (!self.isFirstTime)
    {
        [self setupForCapture];
    }
}

- (void) setupForCapture
{
    [[self view] addSubview:[self snapButton]];
    [[self view] addSubview:[self cancelButton]];
    [self setupTimerLabel];
    
    [self turnOnTorch];
    [self autofocus];
    [self playMusic];
}

- (void) setupCountdown
{
    // sets the delegate
    self.theFinalCountdown.delegate = self;
    
    // background alpha value
    self.theFinalCountdown.backgroundAlpha = 0.2f;
    
    // the color of the counter
    self.theFinalCountdown.countdownColor = [UIColor whiteColor];
    
    // countdown start value
    self.theFinalCountdown.countdownFrom = 3;
    
    
    // necessary to refresh alpha and countdown color
    [self.theFinalCountdown updateAppearance];
    
    [self.theFinalCountdown start];
}

- (void) playMusic
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Play the item using AVPlayer
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:appDelegate.songURL];
    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    [self.player play];
}

- (void) stopMusic
{
    [self.player pause];
}

- (void) autofocus
{
    if ([self.captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus])
    {
        self.captureDevice.focusMode = AVCaptureFocusModeAutoFocus;
    }
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
            
            /*
             // Save to album
             [self.library saveImage:self.imageToDisplay toAlbum:@"Tick Time" withCompletionBlock:^(NSError *error)
             {
             if (error!=nil) {
             NSLog(@"Big error: %@", [error description]);
             }
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved"
             message:@"Your Tick Time capture has been saved. To view it please check the \"Tick Time\" album in photos."
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:@"Share to Social Media",nil];
             
             [alert show];
             }];
             */
            
            // we should stop the camera, since we don't need it anymore. We will open a new vc.
            // this very important, otherwise you may experience memory crashes
            [camera stop];
            
            // show the image
            [blockSafeSelf setCapturedImage:image];
            [blockSafeSelf stopMusic];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [blockSafeSelf pushPreview];
            });


        }
        else
        {
            NSLog(@"An error has occured: %@", error);
        }
    } exactSeenImage:YES];
}

- (void) cancelTouched:(UIButton*) button
{
    [[self navigationController] popToRootViewControllerAnimated:YES];
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
    [timer setDelegate:self];
    [timer setCountDownTime:appDelegate.countdownTimer];
    [timer start];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) pushPreview
{
    TTImagePreviewViewController *preview = (TTImagePreviewViewController*) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Preview"];
        [preview setImageToDisplay:self.capturedImage];
    
    [[self navigationController] pushViewController:preview animated:YES];

 }

#pragma mark - Timer delegate
- (void) timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime
{
    [self snapButtonPressed:nil];
}

#pragma mark - Countdown delegate
- (void) countdownFinished:(SFCountdownView *)view
{
    [view stop];
    [self start];
    [self setupForCapture];
}


@end
