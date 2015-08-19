//
//  TTTickCheckViewController.h
//  TickTime
//
//  Created by AJ Green on 5/4/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "LLSimpleCamera.h"
#import "MZTimerLabel.h"
#import "SFCountdownView.h"

@interface TTTickCheckViewController : LLSimpleCamera <MZTimerLabelDelegate, SFCountdownViewDelegate>

@property (nonatomic, weak) IBOutlet SFCountdownView *theFinalCountdown;

@end
