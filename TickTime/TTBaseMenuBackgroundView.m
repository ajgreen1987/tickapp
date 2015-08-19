//
//  TTBaseMenuBackgroundView.m
//  TickTime
//
//  Created by AJ Green on 5/11/15.
//  Copyright (c) 2015 TickTime. All rights reserved.
//

#import "TTBaseMenuBackgroundView.h"

@implementation TTBaseMenuBackgroundView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color3 = [UIColor colorWithRed: 0.851 green: 0.9 blue: 0.674 alpha: 0.328];
    UIColor* color4 = [UIColor colorWithRed: 0.663 green: 0.769 blue: 0.298 alpha: 0.791];
    UIColor* color0 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0];
    UIColor* color2 = [UIColor colorWithRed: 0.627 green: 0.852 blue: 0.887 alpha: 1];
    UIColor* color5 = [UIColor colorWithRed: 0.589 green: 0.72 blue: 0.172 alpha: 1];
    UIColor* color1 = [UIColor colorWithRed: 0.791 green: 0.918 blue: 0.936 alpha: 0.522];
    
    //// Gradient Declarations
    CGFloat sVGID_1_Locations[] = {0, 0.52, 1};
    CGGradientRef sVGID_1_ = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)color0.CGColor, (id)color1.CGColor, (id)color2.CGColor], sVGID_1_Locations);
    CGFloat sVGID_2_Locations[] = {0, 0.33, 0.79, 1};
    CGGradientRef sVGID_2_ = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)color0.CGColor, (id)color3.CGColor, (id)color4.CGColor, (id)color5.CGColor], sVGID_2_Locations);
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(0, -0.28, self.frame.size.width, (self.frame.size.height*0.71f))];
    CGContextSaveGState(context);
    [rectangle2Path addClip];
    CGContextDrawLinearGradient(context, sVGID_1_,
                                CGPointMake(self.frame.size.width*0.5f, (self.frame.size.height*0.71f)),
                                CGPointMake(self.frame.size.width*0.47f, -0.28),
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    
    //// Rectangle 4 Drawing
    UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRect: CGRectMake(0.32, (self.frame.size.height*0.71f), self.frame.size.width, self.frame.size.height*0.5f)];
    CGContextSaveGState(context);
    [rectangle4Path addClip];
    CGContextDrawLinearGradient(context, sVGID_2_,
                                CGPointMake(self.frame.size.width*0.5f, self.frame.size.height*0.71f),
                                CGPointMake(self.frame.size.width*0.5f, self.frame.size.height),
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    
    //// Cleanup
    CGGradientRelease(sVGID_1_);
    CGGradientRelease(sVGID_2_);
    CGColorSpaceRelease(colorSpace);

}


@end
