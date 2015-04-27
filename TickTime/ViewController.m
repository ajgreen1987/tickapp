//
//  ViewController.m
//  TickTime
//
//  Created by AJ Green on 4/26/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+animatedGIF.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self animateBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) animateBackground
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"gif" ofType:@"gif"];
    NSURL *url=[[NSURL alloc] initFileURLWithPath:path];
    self.animatedBackground.image= [UIImage animatedImageWithAnimatedGIFURL:url];
    
    double delayInSeconds = 10.9f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.animatedBackground.image = [UIImage imageNamed:@"lastFrame"];
    });
}

@end
