//
//  LWHTabbarBottomIView.m
//  ChengXianApp
//
//  Created by mac on 2020/4/26.
//  Copyright © 2020 WuHua . All rights reserved.
//

#import "LWHTabbarBottomIView.h"
@interface LWHTabbarBottomIView ()
@property (nonatomic,strong) UIImageView *centerImage;
@property (nonatomic,strong) UIBezierPath *touchPath;
@end
@implementation LWHTabbarBottomIView

-(instancetype)initWithFrame:(CGRect)rect andimage:(UIImage *)image obveHeight:(NSInteger)height
{
    if (self = [super initWithFrame:rect]) {
        self.backgroundColor = [UIColor clearColor];
        self.centerImage.image = image;
        [self creatSubVeiws];
        
    }
    return self;
}
-(void)creatSubVeiws
{
    [self addSubview:self.centerImage];
    [self addSubview:self.tapButton];
}

-(UIImageView *)centerImage
{
    if (!_centerImage) {
        CGFloat widthCenterImage = 55;
        CGFloat centerOffsetCenterImage = 10;
        _centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widthCenterImage, widthCenterImage)];
        _centerImage.centerX = self.frame.size.width / 2.0;
        _centerImage.centerY = self.frame.size.width / 2.0 - centerOffsetCenterImage;
    }
    return _centerImage;
}
-(UIButton *)tapButton
{
    if (!_tapButton) {
        _tapButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _tapButton.frame = self.bounds;
    }
    return _tapButton;
}
-(void)drawRect:(CGRect)rect
{
    [[UIColor redColor]setFill];
    CGFloat arcFirstPointX = 22;
    CGFloat arcControllPointY = -7;
    CGFloat orY = 20;
    UIBezierPath *touchPath = [UIBezierPath bezierPath];
    self.touchPath = touchPath;
    [touchPath moveToPoint:CGPointMake(0, orY)];
    [touchPath addLineToPoint:CGPointMake(self.width / 2.0 - arcFirstPointX, orY)];
    [touchPath addQuadCurveToPoint:CGPointMake(self.width / 2.0 + arcFirstPointX, orY) controlPoint:CGPointMake(self.width / 2.0 , arcControllPointY)];
    [touchPath addLineToPoint:CGPointMake(self.width, orY)];
    [touchPath addLineToPoint:CGPointMake(self.width , self.height )];
    [touchPath addLineToPoint:CGPointMake(0 , self.height )];
    [touchPath addLineToPoint:CGPointMake(0 , orY )];
    [touchPath closePath];
    [touchPath fill];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    if ([self.touchPath containsPoint:point]) {
        return YES;
    } else {
        return NO;
    }
}

@end
