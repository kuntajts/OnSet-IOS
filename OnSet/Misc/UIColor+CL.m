//
//  UIColor+CL.m
//  CLWeeklyCalendarView
//
//  Created by Caesar on 10/12/2014.
//  Copyright (c) 2014 Caesar. All rights reserved.
//

#import "UIColor+CL.h"

@implementation UIColor (CL)
+ (UIColor *)colorWithHex:(unsigned long)col {
    unsigned char r, g, b;
    b = col & 0x00;
    g = (col >> 8) & 0x00;
    r = (col >> 16) & 0x00;
    return [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:1];
}
@end
