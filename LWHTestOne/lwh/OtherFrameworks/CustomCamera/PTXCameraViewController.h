//
//  PTXCameraViewController.h
//  自定义照相机
//
//  Created by pantianxiang on 17/2/4.
//  Copyright © 2017年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTXCameraViewControllerDelegate;

@interface PTXCameraViewController : UIViewController

@property (nonatomic, assign) id<PTXCameraViewControllerDelegate> delegate;

@end

@protocol PTXCameraViewControllerDelegate <NSObject>

- (void)cameraViewController:(PTXCameraViewController *)cameraViewController didObtainPhoto:(UIImage *)photo; //获得摄像头拍到的照片。
- (void)cameraViewController:(PTXCameraViewController *)cameraViewController didObtainMovieWithUrl:(NSURL *)fileUrl; //获得摄像头录到的视频。

@end