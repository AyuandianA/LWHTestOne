//
//  PTXTopView.m
//  自定义照相机
//
//  Created by pantianxiang on 17/2/6.
//  Copyright © 2017年 ys. All rights reserved.
//

#import "PTXTopView.h"

@interface PTXTopView () {
    UIButton *flashButton;
    UIButton *flashAutoButton;
    UIButton *flashCloseButton;
    UIButton *flashOpenButton;
}

@end

@implementation PTXTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        [self setupView];
    }
    return self;
}

- (void)setupView {
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(20.0, 20.0, 50.0, 50.0)];
//    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [cancelButton setBackgroundColor:[UIColor clearColor]];
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [cancelButton setImage:BundleTabeImage(@"sx_back.png") forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    
    UIButton *toggleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toggleButton setFrame:CGRectMake(self.frame.size.width - 70.0, 20.0, 50.0, 50.0)];
//    [toggleButton setBackgroundColor:[UIColor clearColor]];
    [toggleButton setImage:[UIImage imageNamed:@"btn_video_flip_camera.png"] forState:UIControlStateNormal];
    [toggleButton addTarget:self action:@selector(toggleCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:toggleButton];
    
    flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashButton setFrame:CGRectMake(CGRectGetMinX(toggleButton.frame) - 60.0, 20.0, 50.0, 30.0)];
    [flashButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [flashButton setBackgroundColor:[UIColor clearColor]];
    [flashButton setTitle:@"闪光" forState:UIControlStateNormal];
    [flashButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [flashButton addTarget:self action:@selector(flash:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:flashButton];
    
    flashCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashCloseButton setFrame:CGRectMake(CGRectGetMinX(flashButton.frame) - 45.0, 20.0, 40.0, 30.0)];
    [flashCloseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [flashCloseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [flashCloseButton setBackgroundColor:[UIColor clearColor]];
    [flashCloseButton setTitle:@"关闭" forState:UIControlStateNormal];
    [flashCloseButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [flashCloseButton addTarget:self action:@selector(flashClose:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:flashCloseButton];
    flashCloseButton.hidden = YES;
    flashCloseButton.selected = YES; //默认选中关闭闪光。
    
    flashOpenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashOpenButton setFrame:CGRectMake(CGRectGetMinX(flashCloseButton.frame) - 45.0, 20.0, 40.0, 30.0)];
    [flashOpenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [flashOpenButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [flashOpenButton setBackgroundColor:[UIColor clearColor]];
    [flashOpenButton setTitle:@"打开" forState:UIControlStateNormal];
    [flashOpenButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [flashOpenButton addTarget:self action:@selector(flashOpen:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:flashOpenButton];
    flashOpenButton.hidden = YES;
    
    flashAutoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashAutoButton setFrame:CGRectMake(CGRectGetMinX(flashOpenButton.frame) - 45.0, 20.0, 40.0, 30.0)];
    [flashAutoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [flashAutoButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [flashAutoButton setBackgroundColor:[UIColor clearColor]];
    [flashAutoButton setTitle:@"自动" forState:UIControlStateNormal];
    [flashAutoButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [flashAutoButton addTarget:self action:@selector(flashAuto:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:flashAutoButton];
    flashAutoButton.hidden = YES;
}

#pragma mark - Button Action
- (void)cancel:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickCancelButtonInView:)]) {
        [_delegate didClickCancelButtonInView:self];
    }
}

- (void)toggleCamera:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
//        [sender setTitle:@"后置" forState:UIControlStateNormal];
        
        //选中情况下是前置摄像头，隐藏闪光等按钮。
        flashButton.hidden = YES;
        if (flashButton.selected) {
            flashAutoButton.hidden = YES;
            flashOpenButton.hidden = YES;
            flashCloseButton.hidden = YES;
        }
    }else {
//        [sender setTitle:@"前置" forState:UIControlStateNormal];
        
        //后置摄像头则显示闪光灯按钮。
        flashButton.hidden = NO;
        if (flashButton.selected) {
            flashAutoButton.hidden = NO;
            flashOpenButton.hidden = NO;
            flashCloseButton.hidden = NO;
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickToggleButtonInview:)]) {
        [_delegate didClickToggleButtonInview:self];
    }
}

- (void)flash:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        flashAutoButton.hidden = NO;
        flashOpenButton.hidden = NO;
        flashCloseButton.hidden = NO;
    }else {
        flashAutoButton.hidden = YES;
        flashOpenButton.hidden = YES;
        flashCloseButton.hidden = YES;
    }
    
}

- (void)flashClose:(UIButton *)sender {
    sender.selected = YES;
    flashOpenButton.selected = NO;
    flashAutoButton.selected = NO;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickFlashCloseButtonInview:)]) {
        [_delegate didClickFlashCloseButtonInview:self];
    }
}

- (void)flashOpen:(UIButton *)sender {
    sender.selected = YES;
    flashCloseButton.selected = NO;
    flashAutoButton.selected = NO;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickFlashOpenButtonInview:)]) {
        [_delegate didClickFlashOpenButtonInview:self];
    }
}

- (void)flashAuto:(UIButton *)sender {
    sender.selected = YES;
    flashCloseButton.selected = NO;
    flashOpenButton.selected = NO;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickFlashAutoButtonInview:)]) {
        [_delegate didClickFlashAutoButtonInview:self];
    }
}

@end
