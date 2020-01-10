//
//  MNAssistiveBtn.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/8/24.
//  Copyright © 2019 WuHua . All rights reserved.
//


#import <UIKit/UIKit.h>

@class MNFloatContentBtn;

@interface MNFloatBtn : UIWindow

typedef void (^floatBtnClick)(UIButton *sender);

//显示floatBtn
+ (void)show;
//移除floatBtn在界面显示
+ (void)hidden;
// 获取frame
+ (CGRect)getFrame;
// 获取隐藏状态
+ (BOOL)hiddenStatue;
+(void)closeUserInteractionEnabled;
+(void)showUserInteractionEnabled;
//获取floatBtn对象
+ (MNFloatContentBtn *)sharedBtn;
// 
+ (void)releaseBtn;

@end


@interface MNFloatContentBtn : UIButton

@property (nonatomic, assign)BOOL isShow;

////按钮点击事件
@property (nonatomic, copy)floatBtnClick btnClick;

- (void)setCurrentTime:(NSString *)time;




@end


