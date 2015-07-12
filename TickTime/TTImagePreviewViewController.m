//
//  TTImagePreviewViewController.m
//  TickTime
//
//  Created by AJ Green on 6/28/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTImagePreviewViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
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
    [[self imageView] setImage:self.imageToDisplay];
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
    NSArray *activityItems = @[texttoshare, imagetoshare];
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
