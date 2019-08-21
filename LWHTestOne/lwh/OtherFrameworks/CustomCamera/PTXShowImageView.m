//
//  PTXShowImageView.m
//  自定义照相机
//
//  Created by pantianxiang on 17/2/5.
//  Copyright © 2017年 ys. All rights reserved.
//

#import "PTXShowImageView.h"

@implementation PTXShowImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        [self setupView];
    }
    return self;
}

- (void)setupView {
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
//    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
//    [self addSubview:bgView];
    
    UIButton *retakeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    retakeButton.frame = CGRectMake(20.0, self.frame.size.height - 90.0, 60.0, 60.0);
    [retakeButton setImage:BundleTabeImage(@"se_quxiao.png") forState:UIControlStateNormal];
    [retakeButton addTarget:self action:@selector(retake:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:retakeButton];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(self.frame.size.width - 80.0, self.frame.size.height - 90.0, 60.0, 60.0);
    [sendButton setImage:BundleTabeImage(@"sx_confirm.png") forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendButton];
}

- (void)retake:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickRetakeButonInView:)]) {
        [_delegate didClickRetakeButonInView:self];
    }
}

- (void)send:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickSendButtonInView:)]) {
        [_delegate didClickSendButtonInView:self];
    }
}

@end
