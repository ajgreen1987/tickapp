//
//  TTLabel.m
//  TickTime
//
//  Created by AJ Green on 6/28/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTLabel.h"
#import "AppDelegate.h"

@implementation TTLabel

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self initializer];
    }
    
    return self;
}

- (void) initializer
{
    [self setFont:[AppDelegate systemFontOfSize:self.font.pointSize]];
}

@end
