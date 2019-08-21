//
//  PTXTopView.h
//  自定义照相机
//
//  Created by pantianxiang on 17/2/6.
//  Copyright © 2017年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTXTopViewDelegate;

@interface PTXTopView : UIView

@property (nonatomic, assign) id<PTXTopViewDelegate> delegate;

@end


@protocol PTXTopViewDelegate <NSObject>

- (void)didClickCancelButtonInView:(PTXTopView *)topView; //取消。
- (void)didClickToggleButtonInview:(PTXTopView *)topView;  //镜头切换。
- (void)didClickFlashAutoButtonInview:(PTXTopView *)topView; //自动闪光灯。
- (void)didClickFlashOpenButtonInview:(PTXTopView *)topView; //打开闪光灯。
- (void)didClickFlashCloseButtonInview:(PTXTopView *)topView; //关闭闪光灯。

@end