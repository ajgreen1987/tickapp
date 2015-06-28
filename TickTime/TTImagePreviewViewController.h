//
//  TTImagePreviewViewController.h
//  TickTime
//
//  Created by AJ Green on 6/28/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface TTImagePreviewViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) UIImage *imageToDisplay;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, atomic) ALAssetsLibrary* library;

- (IBAction)handleCancelTouchUpInside:(id)sender;
- (IBAction)handleSaveTouchUpInside:(id)sender;



@end
