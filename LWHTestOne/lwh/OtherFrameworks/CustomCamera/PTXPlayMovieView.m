//
//  PTXPlayMovieView.m
//  自定义照相机
//
//  Created by pantianxiang on 17/2/6.
//  Copyright © 2017年 ys. All rights reserved.
//

#import "PTXPlayMovieView.h"
#import <AVFoundation/AVFoundation.h>

@interface PTXPlayMovieView ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation PTXPlayMovieView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        [self setupView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishPlayMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
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
    if (_delegate && [_delegate respondsToSelector:@selector(didClickRetakeButonInPlayView:)]) {
        [_delegate didClickRetakeButonInPlayView:self];
    }
}

- (void)send:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickSendButtonInPlayView:)]) {
        [_delegate didClickSendButtonInPlayView:self];
    }
}

- (void)setFileUrl:(NSURL *)fileUrl {
    _fileUrl = fileUrl;
    
    [self resetPlayer];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:fileUrl];
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    self.playerLayer.frame = self.frame;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer insertSublayer:_playerLayer atIndex:0];
}

- (void)resetPlayer {
    if (_player) {
        [_player pause];
    }
    
    if (_playerLayer) {
        [_playerLayer removeFromSuperlayer];
    }
}

- (void)play {
    [_player play];
}

- (void)pause {
    [_player pause];
}

//重复播放视频。
- (void)didFinishPlayMovie:(NSNotification *)notification {
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
}

@end
