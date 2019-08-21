//
//  PTXFocusCursorView.m
//  自定义照相机
//
//  Created by pantianxiang on 17/2/6.
//  Copyright © 2017年 ys. All rights reserved.
//
//  聚焦光标。

#import "PTXFocusCursorView.h"

@implementation PTXFocusCursorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    //方框。
    CGContextAddRect(context, rect);
    /********四条向内突出的线********/
    //顶部。
    CGContextMoveToPoint(context, width / 2, 0);
    CGContextAddLineToPoint(context, width / 2, 6.0);
    //左部。
    CGContextMoveToPoint(context, 0, height / 2);
    CGContextAddLineToPoint(context, 6.0, height / 2);
    //底部。
    CGContextMoveToPoint(context, width / 2, height);
    CGContextAddLineToPoint(context, width / 2, height - 6.0);
    //右部。
    CGContextMoveToPoint(context, width, height / 2);
    CGContextAddLineToPoint(context, width - 6.0, height / 2);
    
    CGContextStrokePath(context);
}


@end
