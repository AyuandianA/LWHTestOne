//
//  WJPopoverViewController.h
//  绘图
//
//  Created by fengwenjie on 16/8/26.
//  Copyright © 2016年 fengwenjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WJPopoverViewControllerArrowDirection) {
    WJPopoverViewControllerArrowDirectionTop = 0,    // 上面
    WJPopoverViewControllerArrowDirectionBottom,     // 下面
    WJPopoverViewControllerArrowDirectionLeft,       // 左面
    WJPopoverViewControllerArrowDirectionRight       // 右面
};

typedef NS_ENUM(NSInteger, WJPopoverViewControllerCellPosition) {
    WJPopoverViewControllerCellPositionhorizontal = 0,
    WJPopoverViewControllerCellPositionvertical
};

/** 动画设置，基于transform */
typedef NS_ENUM(NSInteger, WJPopoverViewShowAnimation) {
    WJPopoverViewShowAnimationNormal = 0,      // 从上往下动画
    WJPopoverViewShowAnimationTopBotttom = WJPopoverViewShowAnimationNormal,
    WJPopoverViewShowAnimationTopLeft,         // 左上角放大
    WJPopoverViewShowAnimationTopRight,        // 右上角放大
    WJPopoverViewShowAnimationBottomLeft,      // 左下角放大
    WJPopoverViewShowAnimationBottomRight,     // 右下角放大
    WJPopoverViewShowAnimationBottomTop,       // 从下往上
    WJPopoverViewShowAnimationLeftRight,       // 从左到右
    WJPopoverViewShowAnimationRightLeft        // 从右到左
};

extern NSString *const WJPopoverViewControllerWillAppearNotification;
extern NSString *const WJPopoverViewControllerDidAppearNotification;
extern NSString *const WJPopoverViewControllerWillDisappearNotification;
extern NSString *const WJPopoverViewControllerDidDisappearNotification;


@interface WJPopoverViewController : UIViewController

/** 添加的控制器，展示控制器的view */
@property (nonatomic, strong) UIViewController *viewController;

/** 添加的view，即展示的view */
@property (nonatomic, strong) UIView *showView;

/** 展示view的圆角，default 5.f */
@property (nonatomic, assign) CGFloat cornerRadius;

/** 展示view的边框宽度，default 0.f */
@property (nonatomic, assign) CGFloat borderWidth;

/** 三角形偏移原来位置 x 或 y  offSet像素  */
@property (nonatomic, assign) CGFloat offSet;

/** 背景透明度 */
@property (nonatomic, assign) CGFloat alpha;

/** 展示动画时长 */
@property (nonatomic, assign) NSTimeInterval duration;

/** 展示view的边框颜色, 箭头跟随default 白色 */
@property (nonatomic, strong) UIColor *borderColor;

/** 箭头方向，default anyWhere */
@property (nonatomic, assign) WJPopoverViewControllerArrowDirection arrowDirection;

/** 展示界面与cell是水平还是垂直，default horizontal */
@property (nonatomic, assign) WJPopoverViewControllerCellPosition positionDirection;

@property (nonatomic, assign) WJPopoverViewShowAnimation showAnimation;

/**
 *  构建函数，展示的类型为viewController的view
 *
 *  @param viewController 自定义的viewController
 *
 *  @return WJPopoverViewController
 */
- (instancetype)initWithViewController:(UIViewController *)viewController;

+ (instancetype)popViewWithViewController:(UIViewController *)viewController;

/**
 *  构建函数，展示的类型为view
 *
 *  @param showView 自定义的view
 *
 *  @return WJPopoverViewController
 */
- (instancetype)initWithShowView:(UIView *)showView;

+ (instancetype)popViewWithShowView:(UIView *)showView;


/**
 *  界面的展示基于普通按钮的触发
 *
 *  @param senderEvent        按钮的点击event
 *  @param animation          是否需要动画，默认从上往下
 */
- (void)showPopoverWithTouch:(UIEvent *)senderEvent
                   animation:(BOOL)animation;

/**
 *  界面的展示基于普通按钮的触发
 *
 *  @param senderEvent        按钮的点击event
 *  @param directionAnimation 界面展示时的动画效果
 */
- (void)showPopoverWithTouch:(UIEvent *)senderEvent
          directionAnimation:(WJPopoverViewShowAnimation)directionAnimation;

/**
 *  导航栏按钮触发，并且必须是自定义的按钮, UIBarButtonItem会crash
 *
 *  @param senderEvent        按钮的点击event
 *  @param animation          是否需要动画，默认右上角放大
 */
- (void)showPopoverWithBarButtonItemTouch:(UIEvent *)senderEvent
                                animation:(BOOL)animation;

/**
 *  导航栏按钮触发，并且必须是自定义的按钮, UIBarButtonItem会crash
 *
 *  @param senderEvent        按钮的点击event
 *  @param directionAnimation 界面展示时的动画效果
 */
- (void)showPopoverWithBarButtonItemTouch:(UIEvent *)senderEvent
                       directionAnimation:(WJPopoverViewShowAnimation)directionAnimation;

/**
 *  需要展示的界面是基于tableviewcell
 *
 *  @param tableViewCell 选中的tableviewcell
 *  @param animation     是否需要动画
 */
- (void)showPopoverWithTableView:(UITableViewCell *)tableViewCell
                       animation:(BOOL)animation;

/**
 *  需要展示的界面是基于tableviewcell
 *
 *  @param tableViewCell 选中的tableviewcell
 *  @param direction      相对于cell的位置，是水平还是垂直，默认执行动画
 */
- (void)showPopoverWithTableView:(UITableViewCell *)tableViewCell
              directionAnimation:(WJPopoverViewShowAnimation)directionAnimation;

/**
 *  自定义展示的位置，该位置是用来确定箭头的位置方向即基点
 *
 *  @param touchRect 就像点击按钮的frame，但是这个是自定义的位置
 *  @param animation 是否需要动画，动画可以自行设置，默认从上往下
 */
- (void)showPopoverWithRect:(CGRect)touchRect animation:(BOOL)animation;


/**
 *  移除界面是否需要动画
 *
 *  @param animation 动画
 */
- (void)dissPopoverViewWithAnimation:(BOOL)animation;

/**
 *  移除界面动画时长
 *
 *  @param duration 动画时间
 */
- (void)dissPopoverViewWithAnimationDuration:(NSTimeInterval)duration;

/**
 *  移除界面是否需要动画
 *
 *  @param animation 动画
 */
+ (void)dissPopoverViewWithAnimation:(BOOL)animation;

/**
 *  移除界面动画时长
 *
 *  @param duration 动画时间
 */
+ (void)dissPopoverViewWithAnimationDuration:(NSTimeInterval)duration;

@end
