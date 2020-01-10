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
//#import "UIView+TL.h"
#import "SDWebImage.h"
//#import <Reachability/Reachability.h>
//#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
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
#import "LWHTestOne-Swift.h"

//宏定义
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

// 参数一：当前控制器(适配iOS11以下)，参数二：scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}


//屏幕宽高
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

//状态栏高度
#define StatusHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define NaviH 44
#define TabbarH 49
#define SafeAreaH (isIponeX ? 34 : 0)
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

//测试网址
#pragma mark ------------------------------------------账户中心--------------------------------------

#define URL_API  @"https://cxapi.yimeiq.cn/"//首页
#define User_Account_Index  URL_API@"account/index"//首页
#define User_Account_getLogList  URL_API@"account/get-log-list"//账单列表

#define User_Account_getTixianList  URL_API@"account/get-tixian-list"//提现列表

#define User_Account_getDeductionList  URL_API@"account/get-deduction-list"//分成明细列表
#endif /* LWHHeader_h */
