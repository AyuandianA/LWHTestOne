//
//  PTXTakePhotosView.h
//  自定义照相机
//
//  Created by pantianxiang on 17/2/4.
//  Copyright © 2017年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTXTakePhotosViewDelegate;

@interface PTXTakePhotosView : UIView

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) id<PTXTakePhotosViewDelegate> delegate;

@end


@protocol PTXTakePhotosViewDelegate <NSObject>

- (void)didTriggerTakePhotosInView:(PTXTakePhotosView *)takePhotosView; //拍照。
- (void)beganRecordingVieoInView:(PTXTakePhotosView *)takePhotosView; //开始录制视频。
- (void)endRecordingVieoInView:(PTXTakePhotosView *)takePhotosView; //结束录制视频。

@end