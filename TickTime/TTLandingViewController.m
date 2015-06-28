//
//  ViewController.m
//  TickTime
//
//  Created by AJ Green on 4/26/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTLandingViewController.h"
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"

#define LAST_FRAME                      @"lastFrame"
#define GIF                             @"gif"
#define BACKGROUND_ANIMATION_DURATION   5.1
#define SOCIAL_ANIMATION_DURATION       1.2
#define BUTTON_ALPHA_ZERO               0.0f
#define BUTTON_ALPHA_ONE                1.0f
#define FADE_ANIMATION_DURATION         1.2

@interface TTLandingViewController ()

- (void) animateBackground;
- (void) animateSocialButtons;
- (void) moveButton:(UIButton*)aButton
             fromFrame:(CGRect)aStart
               toFrame:(CGRect)anEnd
          withDuration:(NSTimeInterval)aDuration;
- (void) fadeButton:(UIButton*)aButton
               fromOpacity:(CGFloat)aStart
                 toOpacity:(CGFloat)anEnd
              withDuration:(NSTimeInterval)aDuration;

@end

@implementation TTLandingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self animateBackground];
    [self animateSocialButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Animations

/**
 This method handles the background GIF animation and sets the final frame to a static image on completion
 */
- (void) animateBackground
{
    NSString *path=[[NSBundle mainBundle]pathForResource:GIF
                                                  ofType:GIF];
    
    NSURL *url=[[NSURL alloc] initFileURLWithPath:path];
    self.animatedBackground.image= [UIImage animatedImageWithAnimatedGIFURL:url];
    
    __block TTLandingViewController *blockSafeSelf = self;
    
    double delayInSeconds = BACKGROUND_ANIMATION_DURATION;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        blockSafeSelf.animatedBackground.image = [UIImage imageNamed:LAST_FRAME];
        [blockSafeSelf animateBottomButtons];
    });
}

/**
 This method animates both of the social buttons into place
 */
- (void) animateSocialButtons
{
    [self moveSocialButton:self.facebook];
    
    __block TTLandingViewController *blockSafeSelf = self;
    
    double delayInSeconds = SOCIAL_ANIMATION_DURATION;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [blockSafeSelf moveSocialButton:blockSafeSelf.twitter];
    });

}

/**
 This method fades all bottom buttons in
 */
- (void) animateBottomButtons
{
    [self fadeButton:self.instructions
         fromOpacity:BUTTON_ALPHA_ZERO
           toOpacity:BUTTON_ALPHA_ONE
        withDuration:FADE_ANIMATION_DURATION];

    [self fadeButton:self.resources
         fromOpacity:BUTTON_ALPHA_ZERO
           toOpacity:BUTTON_ALPHA_ONE
        withDuration:FADE_ANIMATION_DURATION];
    
    [self fadeButton:self.settings
         fromOpacity:BUTTON_ALPHA_ZERO
           toOpacity:BUTTON_ALPHA_ONE
        withDuration:FADE_ANIMATION_DURATION];
    
    [self fadeButton:self.savedImages
         fromOpacity:BUTTON_ALPHA_ZERO
           toOpacity:BUTTON_ALPHA_ONE
        withDuration:FADE_ANIMATION_DURATION];
    
    __block TTLandingViewController *blockSafeSelf = self;
    
    double delayInSeconds = SOCIAL_ANIMATION_DURATION;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [blockSafeSelf fadeButton:self.doACheck
                      fromOpacity:BUTTON_ALPHA_ZERO
                        toOpacity:BUTTON_ALPHA_ONE
                     withDuration:FADE_ANIMATION_DURATION];
    });
}

/**
 This method moves a button from a starting frame to another across a duration. It places the button at it's starting frame and sets hidden to NO
 
 @param aButton UIButton to move
 @param aStart  Animation Starting frame
 @param anEnd   AnimationEnding frame
 @param aDuration   Length of time to animate for
 */
- (void) moveButton:(UIButton*)aButton fromFrame:(CGRect)aStart toFrame:(CGRect)anEnd withDuration:(NSTimeInterval)aDuration
{
    [aButton setHidden:NO];
    [aButton setFrame:aStart];
    
    __block UIButton *blockSafeButton = aButton;

    [UIView animateWithDuration:aDuration
                     animations:^{
                         [blockSafeButton setFrame:anEnd];
                     }];
}

/**
 This method fades a button from an alpha value to another across a duration. It sets the starting alpha and sets hidden to NO
 
 @param aButton UIButton to fade
 @param aStart  Starting Alpha
 @param anEnd   Ending Alpha
 @param aDuration   Length of time to animate for
 */
- (void) fadeButton:(UIButton*)aButton fromOpacity:(CGFloat)aStart toOpacity:(CGFloat)anEnd withDuration:(NSTimeInterval)aDuration
{
    [aButton setHidden:NO];
    [aButton setAlpha:aStart];
    __block UIButton *blockSafeButton = aButton;
    
    [UIView animateWithDuration:aDuration
                     animations:^{
                         [blockSafeButton setAlpha:anEnd];
                     }];
}


/**
 This method animates the social buttons from the top of the page
 @param aButton UIButton to animate down from offscreen
 */
- (void) moveSocialButton:(UIButton*)aButton
{
    CGRect currentRect = aButton.frame;
    CGRect startRect = currentRect;
    startRect.origin.y -= currentRect.size.height;

    [self moveButton:aButton
           fromFrame:startRect
             toFrame:currentRect
        withDuration:SOCIAL_ANIMATION_DURATION];
    
}

#pragma mark - Social
- (IBAction)handleFacebookTouchUpInside:(id)sender
{
    [AppDelegate openURL:[NSURL URLWithString:@"https://www.facebook.com/ticktimeapp"]];
}

- (IBAction)handleTwitterTouchUpInside:(id)sender
{
    [AppDelegate openURL:[NSURL URLWithString:@"https://www.twitter.com/ticktimeapp"]];
}
@end
