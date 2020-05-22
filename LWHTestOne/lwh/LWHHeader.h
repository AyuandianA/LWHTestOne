//
//  LWHHeader.h
//  Test
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#ifndef LWHHeader_h
#define LWHHeader_h

//经常引入的头文件
//#import "PortFile.h"//接口文件
#import "NSString+judgement.h"
#import "StorageManager.h"
#import "LJCNetWorking.h"
#import "SDWebImage.h"
#import <MJRefresh/MJRefresh.h>
#import "LJCGIFRefreshHeader.h"
#import "LJCGIFRefreshFooter.h"
#import "UIButton+ImageTitleSpacing.h"
#import "EmptyView.h"
#import "LJCProgressHUD.h"
#import "LJCActionSheet.h"
#import "UserMaterialModel.h"
#import "LWHWkPlayerManager.h"
//李武华新增
#import "Masonry.h"
#import <YYKit/YYKit.h>
#import <UIKit/UIKit.h>



// 参数一：当前控制器(适配iOS11以下)，参数二：scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}


//屏幕宽高
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

//是否刘海屏
#define isIponeX \
({\
BOOL isYes = NO; \
if(@available(iOS 11.0, *)){ \
UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window]; \
if (mainWindow.safeAreaInsets.bottom > 0.0) { \
isYes = YES; \
} \
}\
(isYes);\
})\

//状态栏高度
#define StatusHeight \
({\
    CGFloat statH = 0.0; \
    if ([[UIApplication sharedApplication] isStatusBarHidden]) {\
        statH = SafeAreaH > 0 ? 44 : 20;\
    } else {\
        if(@available(iOS 13.0, *)){\
            statH = [[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager statusBarFrame].size.height;\
        } else {\
            statH = [[UIApplication sharedApplication] statusBarFrame].size.height;\
        }\
    }\
    (statH);\
})\
//导航条高度
#define NaviH 44
//tabbar条高度
#define TabbarH 49
//下屏幕边缘系统横线高度
#define SafeAreaH (isIponeX ? 34 : 0)
//顶部高度
#define TopHeight (NaviH + StatusHeight)
//底部高度
#define BottomHeight (TabbarH + SafeAreaH)
//颜色
#define ColorHex(hex) ([UIColor colorWithRed:(((hex) & 0xFF0000) >> 16)/255.0f green:(CGFloat) (((hex) & 0xFF00) >> 8)/255.0f blue:((hex) & 0xFF)/255.0f alpha:1])
#define RGB(a,b,c,d)   [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:d]
#define MainBackColor RGB(243, 243, 243, 1)
#define MainTopColor RGB(254, 92, 46, 1)
// 字体
#define TextFont ((KScreenWidth > 375) ? 17 : (KScreenWidth > 320) ? 16 : 15)
// HUD提示框半径
#define HudSize ((KScreenWidth > 375) ? 24 : (KScreenWidth > 320) ? 20 : 15)

#define User_Id @"0"
// 获取图片路径
#define BundleTabeImage(name) [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"image.bundle" ofType:nil]] pathForResource:name ofType:nil]]


#endif /* LWHHeader_h */
