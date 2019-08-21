//
//  LJCSwitch.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/31.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "LJCSwitch.h"

@interface LJCSwitch ()

@property(nonatomic, strong) UIView *view;
@property(nonatomic, copy) LJCSwitchBlock block;
@property(nonatomic, assign, getter=isNeedVibration) BOOL needVibration;

@end

@implementation LJCSwitch

- (instancetype)init {
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor clearColor]];
        [self addSubview:view];
        [self setView:view];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeState:)];
        [view addGestureRecognizer:gestureRecognizer];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[self view] setFrame:[self bounds]];
    
    return;
}

- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
    
    return;
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    [self vibration];
    [super setOn:on animated:animated];
    
    return;
}

- (void)addBlock:(LJCSwitchBlock)block {
    [self setBlock:block];
    
    return;
}

- (void)changeState:(UITapGestureRecognizer *)gestureRecognizer {
    LJCSwitchBlock block = [self block];
    if (block) {
        [self setNeedVibration:YES];
        __weak typeof(self) weakSelf = self;
        block(self, ^() {
            [weakSelf setNeedVibration:NO];
        });
    }
    
    return;
}

- (void)vibration {
    
    if ([self isNeedVibration]) {
        if (@available(iOS 10.0, *)) {
            UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
            [feedBackGenertor prepare];
            [feedBackGenertor impactOccurred];
        } else {
            // Fallback on earlier versions
        }
        
        [self setNeedVibration:NO];
    }
    
    return;
}

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

@end
