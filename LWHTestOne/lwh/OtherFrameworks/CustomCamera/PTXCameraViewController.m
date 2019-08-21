//
//  PTXCameraViewController.m
//  自定义照相机
//
//  Created by pantianxiang on 17/2/4.
//  Copyright © 2017年 ys. All rights reserved.
//

#import "PTXCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PTXTopView.h"
#import "PTXTakePhotosView.h"
#import "PTXShowImageView.h"
#import "PTXFocusCursorView.h"
#import "PTXPlayMovieView.h"


#define PTXSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define PTXSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define PTX_VIDEO_MAX_DURATION 20 //视频最大时长。

@interface PTXCameraViewController () <PTXTakePhotosViewDelegate,PTXShowImageViewDelegate,PTXTopViewDelegate,PTXPlayMovieViewDelegate>
{
    BOOL statusBarHidden;
    
    PTXTakePhotosView *takePhotosView;
    UILabel *descLabel;
    
    CGFloat videoDuration;
    NSTimer *progressTimer;
    
    AVCaptureSession *captureSession; //负责输入和输出设备之间的数据交互。
    AVCaptureDeviceInput *captureDeviceInput; //负责从设备(AVCaptureDevice)中获得输入。
    AVCaptureStillImageOutput *captureStillImageOutput; //照片输出。
    AVCaptureMovieFileOutput *captureMovieFileOutput; //视频输出。
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer; //图像预览层，实时显示捕获的图像。
    
    NSURL *recodingUrl;
}

@property (nonatomic, strong) PTXShowImageView *showImageView;
@property (nonatomic, strong) PTXPlayMovieView *playMovieView;
@property (nonatomic, strong) PTXFocusCursorView *focusCursorView;

@end

@implementation PTXCameraViewController

- (BOOL)prefersStatusBarHidden {
    return statusBarHidden;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
    statusBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    
    if (!captureDeviceInput) {
        CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (systemVersion > 9.0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取摄像头失败" message:@"该设备不存在或无法获取摄像头" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                NSLog(@"点击了确定");
            }]];
            
            [self presentViewController:alertController animated:YES completion:^{
            }];
        }else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"获取摄像头失败" message:@"该设备不存在或无法获取摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }else {
        //显示光标。
        CGPoint point = self.view.center;
        CGPoint cameraPoint = [captureVideoPreviewLayer captureDevicePointOfInterestForPoint:self.view.center]; //把中心点转换为预览图层上的位置。
        [self setFocusCursorWithPoint:point];
        [self focusWithModel:AVCaptureFocusModeAutoFocus exposureModel:AVCaptureExposureModeAutoExpose point:cameraPoint];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    statusBarHidden = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    
    [captureSession stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    statusBarHidden = NO;
    
    [self setupView];
    [self setupCaptureSession];
}

- (void)setupView {
    PTXTopView *topView = [[PTXTopView alloc]initWithFrame:CGRectMake(0, 0, PTXSCREENWIDTH, 64)];
    topView.delegate = self;
    [self.view addSubview:topView];
    
    takePhotosView = [[PTXTakePhotosView alloc]initWithFrame:CGRectMake((PTXSCREENWIDTH - 80.0) / 2, PTXSCREENHEIGHT - 20.0 - 80.0, 80.0, 80.0)];
    takePhotosView.delegate = self;
    [self.view addSubview:takePhotosView];
    
    descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(takePhotosView.frame) - 29.0, PTXSCREENWIDTH, 14.0)];
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.font = [UIFont systemFontOfSize:13.0];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.text = @"点击拍照，长按录像";
    [self.view addSubview:descLabel];
}

- (void)setupCaptureSession {
    //初始会话。
    captureSession = [[AVCaptureSession alloc]init];
    if ([captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        [captureSession setSessionPreset:AVCaptureSessionPreset1280x720]; //设置分辨率。
    }
    
    //初始化视频输入对象。
    AVCaptureDevice *captureDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
    if (!captureDevice) {
//        NSLog(@"获取后置摄像头时出现问题。");
        return;
    }
    NSError *error = nil;
    captureDeviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {
//        NSLog(@"获取设备输入对象时出现问题。");
        return;
    }
    [self setCaptureDeviceFlashModel:AVCaptureFlashModeOff]; //默认关闭闪光灯。
    
    //初始化音频输入对象。
    AVCaptureDevice *audioCatureDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio]firstObject];
    error = nil;
    AVCaptureDeviceInput *audioCaptureDeviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:audioCatureDevice error:&error];
    if (error) {
//        NSLog(@"获取设备输入对象时出现问题。");
        return;
    }
    
    //初始化输出。
    captureStillImageOutput = [[AVCaptureStillImageOutput alloc]init];
    captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc]init];
    
    //添加输入输出到会话中。
    if ([captureSession canAddInput:captureDeviceInput]) {
        [captureSession addInput:captureDeviceInput];
    }
    if ([captureSession canAddInput:audioCaptureDeviceInput]) {
        [captureSession addInput:audioCaptureDeviceInput];
    }
    if ([captureSession canAddOutput:captureStillImageOutput]) {
        [captureSession addOutput:captureStillImageOutput];
    }
    if ([captureSession canAddOutput:captureMovieFileOutput]) {
        [captureSession addOutput:captureMovieFileOutput];
    }
    
    //初始化图像预览层。
    captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:captureSession];
    captureVideoPreviewLayer.frame = self.view.bounds;
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:captureVideoPreviewLayer atIndex:0];
    
    [captureSession startRunning];
}

#pragma mark - PTXTopViewDelegate
#pragma mark 取消
- (void)didClickCancelButtonInView:(PTXTopView *)topView {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark 切换摄像头
- (void)didClickToggleButtonInview:(PTXTopView *)topView {
    AVCaptureDevice *currentDevice = [captureDeviceInput device];
    AVCaptureDevicePosition currentPosition = [currentDevice position];
    
    AVCaptureDevice *toDevice = nil;
    AVCaptureDevicePosition toPosition = AVCaptureDevicePositionFront;
    if (currentPosition == AVCaptureDevicePositionUnspecified ||
        currentPosition == AVCaptureDevicePositionFront) {
        toPosition = AVCaptureDevicePositionBack;
    }
    toDevice = [self getCameraDeviceWithPosition:toPosition];
    NSError *error = nil;
    AVCaptureDeviceInput *toDeviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:toDevice error:&error];
    if (error) {
//        NSLog(@"切换摄像头失败！");
        return;
    }
    
    //添加翻转动画。
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    NSString *subtype = toPosition == AVCaptureDevicePositionFront ? kCATransitionFromLeft : kCATransitionFromRight;
    animation.subtype = subtype;
    [captureVideoPreviewLayer addAnimation:animation forKey:nil];
    
    //改变会话的配置前一定要先开启配置，配置完成后再提交配置。
    [captureSession beginConfiguration];
    [captureSession removeInput:captureDeviceInput];
    if ([captureSession canAddInput:toDeviceInput]) {
        [captureSession addInput:toDeviceInput];
        captureDeviceInput = toDeviceInput;
    }
    [captureSession commitConfiguration];
}

#pragma mark 自动闪光
- (void)didClickFlashAutoButtonInview:(PTXTopView *)topView {
    [self setCaptureDeviceFlashModel:AVCaptureFlashModeAuto];
}

#pragma mark 打开闪光
- (void)didClickFlashOpenButtonInview:(PTXTopView *)topView {
    [self setCaptureDeviceFlashModel:AVCaptureFlashModeOn];
}

#pragma mark 关闭闪光
- (void)didClickFlashCloseButtonInview:(PTXTopView *)topView {
    [self setCaptureDeviceFlashModel:AVCaptureFlashModeOff];
}

#pragma mark - PTXTakePhotosViewDelegate
#pragma mark 拍照
- (void)didTriggerTakePhotosInView:(PTXTakePhotosView *)takePhotosView {
    //根据设备输出获得连接。
    AVCaptureConnection *captureConnection = [captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!captureConnection) {
//        NSLog(@"拍照失败！");
        return;
    }
    
    [captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
//            NSLog(@"获取照片失败！");
            return;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        self.showImageView.image = [UIImage imageWithData:imageData];
        self.showImageView.hidden = NO;
        
        [captureSession stopRunning];
    }];
}

#pragma mark 开始录像
- (void)beganRecordingVieoInView:(PTXTakePhotosView *)takePhotosView {
    [self setupTimer];
    descLabel.text = @"0秒";
    
    //根据设备输出获得连接。
    AVCaptureConnection *captureConnection = [captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!captureConnection) {
//        NSLog(@"录像失败！");
        return;
    }
    
    if (![captureMovieFileOutput isRecording]) {
        NSString *outputFilePath = [NSTemporaryDirectory() stringByAppendingString:@"tempMovie.mov"];
//        NSLog(@"recoding movie path is: %@",outputFilePath);
        recodingUrl = [NSURL fileURLWithPath:outputFilePath];
        [captureMovieFileOutput startRecordingToOutputFileURL:recodingUrl recordingDelegate:self];
    }
}

#pragma mark 结束录像
- (void)endRecordingVieoInView:(PTXTakePhotosView *)takePhotosView {
    [self endRecordingVieo];
}

#pragma mark - PTXShowImageViewDelegate
#pragma mark 重新拍照
- (void)didClickRetakeButonInView:(PTXShowImageView *)showImageView {
    _showImageView.hidden = YES;
    [captureSession startRunning];
}

#pragma mark 发送照片
- (void)didClickSendButtonInView:(PTXShowImageView *)showImageView {
    if (_delegate && [_delegate respondsToSelector:@selector(cameraViewController:didObtainPhoto:)]) {
        [_delegate cameraViewController:self didObtainPhoto:_showImageView.image];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - PTXPlayMovieViewDelegate
#pragma mark 重新录像
- (void)didClickRetakeButonInPlayView:(PTXPlayMovieView *)playMovieView {
    _playMovieView.hidden = YES;
    [_playMovieView pause];
    [captureSession startRunning];
}

#pragma mark 发送录像
- (void)didClickSendButtonInPlayView:(PTXPlayMovieView *)playMovieView {
    [_playMovieView pause];
    if (_delegate && [_delegate respondsToSelector:@selector(cameraViewController:didObtainMovieWithUrl:)]) {
        [_delegate cameraViewController:self didObtainMovieWithUrl:recodingUrl];
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - Private Methods
- (void)setCaptureDeviceFlashModel:(AVCaptureFlashMode)model {
    AVCaptureDevice *captureDevice = [captureDeviceInput device];
    NSError *error;
    //改变设备属性前一定先要上锁，设置完之后再解锁。
    if ([captureDevice lockForConfiguration:&error]) {
        if ([captureDevice isFlashModeSupported:model]) {
            [captureDevice setFlashMode:model];
        }
        [captureDevice unlockForConfiguration];
    }else {
//        NSLog(@"设置闪光灯模式发生错误，错误信息:%@",error.localizedDescription);
    }
}

- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)position {
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

#pragma mark 获取聚焦点。
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    //限制点击的范围，防止光标与拍照按钮重叠。
    if (point.y > CGRectGetMidY(descLabel.frame) - 40.0) {
        return;
    }
    
    //把当前点转换为预览图层上的点。
    CGPoint cameraPoint = [captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    
    [self setFocusCursorWithPoint:point];
    [self focusWithModel:AVCaptureFocusModeAutoFocus exposureModel:AVCaptureExposureModeAutoExpose point:cameraPoint];
}

#pragma mark 设置聚焦和曝光。
- (void)focusWithModel:(AVCaptureFocusMode)focusModel exposureModel:(AVCaptureExposureMode)exposureModel point:(CGPoint)point {
    AVCaptureDevice *captureDevice = [captureDeviceInput device];
    NSError *error = nil;
    if ([captureDevice lockForConfiguration:&error]) {
        //设置聚焦。
        if ([captureDevice isFocusModeSupported:focusModel]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        //设置曝光
        if ([captureDevice isExposureModeSupported:exposureModel]) {
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
            
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
        
        [captureDevice unlockForConfiguration];
    }else {
//        NSLog(@"设置聚焦发生错误，错误信息:%@",error.localizedDescription);
    }
}

#pragma mark 显示光标位置。
- (void)setFocusCursorWithPoint:(CGPoint)point {
    self.focusCursorView.center = point;
    self.focusCursorView.alpha = 1.0;
    self.focusCursorView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [UIView animateWithDuration:0.2 animations:^{
        self.focusCursorView.transform = CGAffineTransformIdentity;
    }];
    [UIView animateWithDuration:3.0 animations:^{
        self.focusCursorView.alpha = 0;
    }];
}

- (void)setupTimer {
    videoDuration = 0;
    progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(recording) userInfo:nil repeats:YES];
}

- (void)removeTimer {
    [progressTimer invalidate];
    progressTimer = nil;
}

- (void)recording {
    videoDuration += 1;
    takePhotosView.progress = videoDuration / PTX_VIDEO_MAX_DURATION;
    descLabel.text = [NSString stringWithFormat:@"%.0f秒",videoDuration];
    
    if (videoDuration >= PTX_VIDEO_MAX_DURATION) {
        [self endRecordingVieo]; //视频长度到达最大值，结束录像。
    }
}

- (void)endRecordingVieo {
    [self removeTimer];
    descLabel.text = @"点击拍照，长按录像";
    
    if ([captureMovieFileOutput isRecording]) {
        [captureMovieFileOutput stopRecording];
    }
    [captureSession stopRunning];
    
    self.playMovieView.hidden = NO;
    self.playMovieView.fileUrl = recodingUrl;
    [self.playMovieView play];
}

#pragma mark - Getter
- (PTXShowImageView *)showImageView {
    if (!_showImageView) {
        _showImageView = [[PTXShowImageView alloc]initWithFrame:self.view.bounds];
        _showImageView.delegate = self;
        [self.view addSubview:_showImageView];
    }
    return  _showImageView;
}

- (PTXFocusCursorView *)focusCursorView {
    if (!_focusCursorView) {
        _focusCursorView = [[PTXFocusCursorView alloc]initWithFrame:CGRectMake(0, 0, 80.0, 80.0)];
        [self.view addSubview:_focusCursorView];
    }
    return _focusCursorView;
}

- (PTXPlayMovieView *)playMovieView {
    if (!_playMovieView) {
        _playMovieView = [[PTXPlayMovieView alloc]initWithFrame:self.view.bounds];
        _playMovieView.delegate = self;
        [self.view addSubview:_playMovieView];
    }
    return _playMovieView;
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
