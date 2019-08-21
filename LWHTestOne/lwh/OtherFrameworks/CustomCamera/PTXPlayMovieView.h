//
//  PTXPlayMovieView.h
//  自定义照相机
//
//  Created by pantianxiang on 17/2/6.
//  Copyright © 2017年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTXPlayMovieViewDelegate;

@interface PTXPlayMovieView : UIView

@property (nonatomic, strong) NSURL *fileUrl;

@property (nonatomic, assign) id<PTXPlayMovieViewDelegate> delegate;

- (void)play;
- (void)pause;

@end

@protocol PTXPlayMovieViewDelegate <NSObject>

- (void)didClickRetakeButonInPlayView:(PTXPlayMovieView *)playMovieView; //重拍。
- (void)didClickSendButtonInPlayView:(PTXPlayMovieView *)playMovieView; //发送视频。

@end