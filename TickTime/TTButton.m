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
        [self initializerFontSize:self.titleLabel.font.pointSize];
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initializerFontSize:self.titleLabel.font.pointSize];
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame andFontSize:(CGFloat)aFontSize
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initializerFontSize:aFontSize];
    }
    
    return self;
}

- (void) initializerFontSize:(CGFloat)aFontSize
{
    [[self titleLabel] setFont:[AppDelegate systemFontOfSize:aFontSize]];
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
