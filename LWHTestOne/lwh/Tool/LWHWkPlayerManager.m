//
//  LWHWkPlayerManager.m
//  ChengXianApp
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "LWHWkPlayerManager.h"
#import "WMPlayer.h"
static LWHWkPlayerManager *playerManager = nil;
static dispatch_once_t onceToken;

@interface LWHWkPlayerManager ()<WMPlayerDelegate>

@property(nonatomic,strong)UIView *playerSuperView;
@property(nonatomic,strong)WMPlayer *wmPlayer;
@property(nonatomic,assign)BOOL isPause;

@end

@implementation LWHWkPlayerManager
+ (instancetype)sharePlayer {
    
    dispatch_once(&onceToken, ^{
        
        if (!playerManager) {
            playerManager = [[LWHWkPlayerManager alloc] init];
        }
        
    });
    
    return playerManager;
}


-(void)setUpUrl:(NSString *)url andPath:(NSIndexPath *)path andSuperView:(UIView *)superView
{
    self.playerSuperView = superView;
    //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    WMPlayerModel *playerModel = [[WMPlayerModel alloc]init];
    playerModel.videoURL = [NSURL URLWithString:url];
    playerModel.indexPath = path;
    self.wmPlayer = [[WMPlayer alloc] init];
    self.wmPlayer.backBtnStyle = BackBtnStyleNone;
    self.wmPlayer.tintColor = MainTopColor;
    self.wmPlayer.delegate = self;
    self.wmPlayer.playerModel = playerModel;
    [self.wmPlayer returnButtonLocationiiInStatusBarBBottom:NO];
    [superView addSubview:self.wmPlayer];
    [self.wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(superView);
    }];
    self.isPause = NO;
    [self.wmPlayer play];
}
-(BOOL)releaseWMPlayer{
    
    if (self.wmPlayer != nil) {
        [self.wmPlayer pause];
        [self.wmPlayer removeFromSuperview];
        self.wmPlayer = nil;
        self.playerSuperView = nil;
        self.isPause = YES;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)isPlaying
{
    if (self.wmPlayer) {
        return YES;
    }else{
        return NO;
    }
}
- (void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (self.wmPlayer.isFullscreen) {//全屏
        [self toOrientation:UIInterfaceOrientationPortrait];
        [self.wmPlayer returnButtonLocationiiInStatusBarBBottom:NO];
    }else{//非全屏
        [self toOrientation:UIInterfaceOrientationLandscapeRight];
        [self.wmPlayer returnButtonLocationiiInStatusBarBBottom:YES];
    }
}
- (void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    if(self.wmPlayer.isFullscreen==NO){
        
    }else{
        [[self.playerSuperView viewController] setNeedsStatusBarAppearanceUpdate];
    }
    
}
- (void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    //    NSLog(@"didDoubleTaped");
    if (self.isPause) {
        self.isPause = NO;
        [self.wmPlayer play];
    }else{
        self.isPause = YES;
        [self.wmPlayer pause];
    }
}

/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange:(NSNotification *)notification{
    if (self.wmPlayer==nil){
        return;
    }
    if (self.wmPlayer.playerModel.verticalVideo) {
        return;
    }
    if (self.wmPlayer.isLockScreen){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            //            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            //            NSLog(@"第0个旋转方向---电池栏在上");
            [self toOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            //            NSLog(@"第2个旋转方向---电池栏在左");
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            //            NSLog(@"第1个旋转方向---电池栏在右");
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        default:
            break;
    }
}
//点击进入,退出全屏,或者监测到屏幕旋转去调用的方法
-(void)toOrientation:(UIInterfaceOrientation)orientation{
    //获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    [self.wmPlayer removeFromSuperview];
    //根据要旋转的方向,使用Masonry重新修改限制
    if (orientation ==UIInterfaceOrientationPortrait) {
        [self.playerSuperView addSubview:self.wmPlayer];
        self.wmPlayer.isFullscreen = NO;
        //        self.wmPlayer.backBtnStyle = BackBtnStyleClose;
        [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.wmPlayer.superview);
        }];
        
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self.wmPlayer];
        self.wmPlayer.isFullscreen = YES;
        //        self.wmPlayer.backBtnStyle = BackBtnStylePop;
        if(currentOrientation ==UIInterfaceOrientationPortrait){
            if (self.wmPlayer.playerModel.verticalVideo) {
                [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.wmPlayer.superview);
                }];
            }else{
                [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@([UIScreen mainScreen].bounds.size.height));
                    make.height.equalTo(@([UIScreen mainScreen].bounds.size.width));
                    make.center.equalTo(self.wmPlayer.superview);
                }];
            }
            
        }else{
            if (self.wmPlayer.playerModel.verticalVideo) {
                [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.wmPlayer.superview);
                }];
            }else{
                [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
                    make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
                    make.center.equalTo(self.wmPlayer.superview);
                }];
            }
            
        }
    }
    //iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    //也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
    if (self.wmPlayer.playerModel.verticalVideo) {
        [[self.playerSuperView viewController] setNeedsStatusBarAppearanceUpdate];
    }else{
        [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
        //更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
        //给你的播放视频的view视图设置旋转
        [UIView animateWithDuration:0.4 animations:^{
            self.wmPlayer.transform = CGAffineTransformIdentity;
            self.wmPlayer.transform = [WMPlayer getCurrentDeviceOrientation];
            [self.wmPlayer layoutIfNeeded];
            [[self.playerSuperView viewController] setNeedsStatusBarAppearanceUpdate];
        }];
    }
}
- (void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    //    NSLog(@"wmplayerDidFailedPlay");
}
- (void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    //    NSLog(@"wmplayerDidReadyToPlay");
}
- (void)wmplayerGotVideoSize:(WMPlayer *)wmplayer videoSize:(CGSize )presentationSize{
    
}
- (void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    //    NSLog(@"wmplayerDidFinishedPlay");
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"wmplayerFinishedThePlay" object:nil];
}
//操作栏隐藏或者显示都会调用此方法
- (void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL)isHidden{
    [[self.playerSuperView viewController] setNeedsStatusBarAppearanceUpdate];
}


@end
