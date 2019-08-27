//
//  PTXShowImageView.h
//  自定义照相机
//
//  Created by pantianxiang on 17/2/5.
//  Copyright © 2017年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTXShowImageViewDelegate;

@interface PTXShowImageView : UIImageView

@property (nonatomic, assign) id<PTXShowImageViewDelegate> delegate;

@end


@protocol PTXShowImageViewDelegate <NSObject>

- (void)didClickRetakeButonInView:(PTXShowImageView *)showImageView; //重拍。
- (void)didClickSendButtonInView:(PTXShowImageView *)showImageView; //发送图片。

@end