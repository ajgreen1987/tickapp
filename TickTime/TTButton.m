//
//  TTButton.m
//  TickTime
//
//  Created by AJ Green on 6/27/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTButton.h"
#import "AppDelegate.h"

@implementation TTButton

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self initializer];
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initializer];
    }
    
    return self;
}

- (void) initializer
{
    [[self titleLabel] setFont:[AppDelegate systemFontOfSize:self.titleLabel.font.pointSize]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundImage:[UIImage imageNamed:@"button"]
                    forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"button_selected"]
                    forState:UIControlStateHighlighted];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
