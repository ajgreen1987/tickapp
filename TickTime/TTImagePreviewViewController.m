//
//  TTImagePreviewViewController.m
//  TickTime
//
//  Created by AJ Green on 6/28/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTImagePreviewViewController.h"
#import "AppDelegate.h"

@interface TTImagePreviewViewController ()

@end

@implementation TTImagePreviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.library = [[ALAssetsLibrary alloc] init];
}

- (void) viewDidAppear:(BOOL)animated
{
    if (self.imageView.image == nil)
    {
        [self handleSaveTouchUpInside:nil];
    }
    else
    {
        [[self imageView] setImage:self.imageToDisplay];
    }
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

- (IBAction)handleCancelTouchUpInside:(id)sender
{
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (IBAction)handleSaveTouchUpInside:(id)sender
{
    // Show share sheet
    NSString *texttoshare = @"Just completed a TickTime check!";
    UIImage *imagetoshare = self.imageToDisplay;
    NSArray *activityItems = (imagetoshare == nil) ? @[self,texttoshare] : @[self,texttoshare, imagetoshare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    NSMutableArray *excluded = [[NSMutableArray alloc] initWithObjects:UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToFlickr, UIActivityTypeAddToReadingList, UIActivityTypeAirDrop, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMail, UIActivityTypeMessage,UIActivityTypePostToFlickr, UIActivityTypePostToTencentWeibo, UIActivityTypePostToVimeo, UIActivityTypePostToWeibo, UIActivityTypePrint, nil];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (![appDelegate shouldShowFacebook])
    {
        [excluded addObject:UIActivityTypePostToFacebook];
    }
    if (![appDelegate shouldShowTwitter])
    {
        [excluded addObject:UIActivityTypePostToTwitter];
    }
    
    activityVC.excludedActivityTypes = excluded;
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
    [activityVC setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError){
        
        if (activityError == nil)
        {
            if ([activityType isEqualToString:UIActivityTypePostToFacebook])
            {
                
            }
            else if([activityType isEqualToString:UIActivityTypePostToTwitter])
            {
            }
        }
        else
        {
            // Error alert!
        }
        
    }];
}

- (id) activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    if ([activityType isEqualToString:UIActivityTypePostToFacebook])
    {
        return @"I just did a #TickCheck with @TickTimeApp! Download TickTime: bit.ly/adfjh3fhg”";
    }
    else if ([activityType isEqualToString:UIActivityTypePostToTwitter])
    {
        return @"I just did a #TickCheck with @TickTime! Download TickTime: bit.ly/adfjh3fhg";
    }
    else {
        return nil;
    }
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title containsString:@"Share"])
    {
        
    }
    else
    {
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }
    
}


@end
