//
//  LWHTarbarView.m
//  LWHTestOne
//
//  Created by mac on 2020/4/27.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHTarbarView.h"
#import "LWHTabbarBottomIView.h"

@implementation LWHTarbarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}
-(void)creatSubViews
{
    CGFloat obveHeight = 20;
    LWHTabbarBottomIView *bottomCenterBar = [[LWHTabbarBottomIView alloc]initWithFrame:CGRectMake(0, -obveHeight, self.width, self.height + obveHeight) andimage:[UIImage imageNamed:@"left_return_white"] obveHeight:obveHeight];
    self.arcView = bottomCenterBar;
    [self addSubview:bottomCenterBar];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint tp = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    for (UIView *subView in self.subviews) {
        CGPoint tp = [subView convertPoint:point fromView:self];
        if (CGRectContainsPoint(subView.bounds, tp)) {
            return YES;
        }
    }
   return NO;
 }
@end
