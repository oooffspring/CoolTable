//
//  CustomFooter.m
//  CoolTable
//
//  Created by offspring on 13-1-13.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import "CustomFooter.h"

@implementation CustomFooter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGColorRef redColor = [[UIColor redColor] CGColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, redColor);
    CGContextFillRect(context, rect);
}

@end
