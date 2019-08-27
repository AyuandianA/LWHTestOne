//
//  PTXTakePhotosView.m
//  自定义照相机
//
//  Created by pantianxiang on 17/2/4.
//  Copyright © 2017年 ys. All rights reserved.
//

#import "PTXTakePhotosView.h"

#define PTX_PROGRESS_WIDTH 4.0

@interface PTXTakePhotosView () {
    UILongPressGestureRecognizer *longPressGR;
}

@end

@implementation PTXTakePhotosView

- (void)dealloc {
    [longPressGR removeObserver:self forKeyPath:@"state"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPressGR];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGR];
        
        [longPressGR addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, PTX_PROGRESS_WIDTH);
    
    CGFloat radius = (self.frame.size.width - 2 * PTX_PROGRESS_WIDTH) / 2;
    CGContextAddArc(context, self.frame.size.width / 2, self.frame.size.height / 2, radius, 0, M_PI * 2, 1);
    CGContextStrokePath(context);
    
    if (_progress > 0) {
        CGFloat angle = 2 * M_PI * _progress - M_PI_2;
        
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:90.0/255.0 green:190.0/255.0 blue:247.0/255.0 alpha:1.0].CGColor);
        CGContextAddArc(context, self.frame.size.width / 2, self.frame.size.height / 2, radius, -M_PI_2, angle, 0);
        CGContextStrokePath(context);
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(beganRecordingVieoInView:)]) {
        [_delegate beganRecordingVieoInView:self];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        CGPoint center = self.center;
        CGRect frame = self.frame;
        frame.size.width = frame.size.width * 1.3;
        frame.size.height = frame.size.height  * 1.3;
        self.frame = frame;
        self.center = center;
    } completion:^(BOOL finished) {
        [self setNeedsDisplay];
    }];
}

- (void)tap:(UITapGestureRecognizer *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didTriggerTakePhotosInView:)]) {
        [_delegate didTriggerTakePhotosInView:self];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"state"]) {
        UIGestureRecognizerState state = ((UILongPressGestureRecognizer *)object).state;
        if (state == UIGestureRecognizerStateEnded) {
            if (_delegate && [_delegate respondsToSelector:@selector(endRecordingVieoInView:)]) {
                [_delegate endRecordingVieoInView:self];
            }
            
            self.progress = 0;
            [self setNeedsDisplay];
            
            [UIView animateWithDuration:0.25 animations:^{
                CGPoint center = self.center;
                CGRect frame = self.frame;
                frame.size.width = frame.size.width / 1.3;
                frame.size.height = frame.size.height / 1.3;
                self.frame = frame;
                self.center = center;
            } completion:^(BOOL finished) {
                [self setNeedsDisplay];
            }];
        }
    }
}

#pragma mark - Setter
- (void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        return;
    }
    
    _progress = progress;
    [self setNeedsDisplay];
}

@end
