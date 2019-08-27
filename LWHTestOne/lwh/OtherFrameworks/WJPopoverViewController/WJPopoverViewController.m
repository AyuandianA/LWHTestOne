//
//  WJPopoverViewController.m
//  绘图
//
//  Created by fengwenjie on 16/8/26.
//  Copyright © 2016年 fengwenjie. All rights reserved.
//

#import "WJPopoverViewController.h"

NSString *const WJPopoverViewControllerWillAppearNotification = @"WillAppearNotification";
NSString *const WJPopoverViewControllerDidAppearNotification = @"DidAppearNotification";
NSString *const WJPopoverViewControllerWillDisappearNotification = @"WillDisappearNotification";
NSString *const WJPopoverViewControllerDidDisappearNotification = @"DidDisappearNotification";

#define WJScreenBounds [UIScreen mainScreen].bounds            // 屏幕frame
#define WJScreenWidth [UIScreen mainScreen].bounds.size.width  // 屏幕宽度
#define WJScreenHeight [UIScreen mainScreen].bounds.size.height// 屏幕高度

#define WJKeyWindow [UIApplication sharedApplication].keyWindow// 窗口

#define WJStatusBarHeight 20.f        // 状态栏的高度
#define WJArrowHeight 10.f            // 三角形箭头的高度
#define WJMargin 8.f                  // 距离两边一个像素点，不一定都有使用

/** 计算一段代码的执行时间 */
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

@interface WJPopoverViewController ()

@property (nonatomic, strong) UIControl *cancelControl;

@property (nonatomic, assign) CGSize contentSize; // 传进来的view的大小

@property (nonatomic, assign) CGPoint arrowStartPoint; // 记录三角形剪头的开始位置

@property (nonatomic, assign) CGRect contentViewFrame; // 需要展示的view的frame

@property (nonatomic, assign) CGPoint transformScale;

@property (nonatomic, assign, getter=isCustomArrowDirection) BOOL customArrowDirection;

@property (nonatomic, assign, getter=isCustomShowAnimation) BOOL customShowAnimation;

@property (nonatomic, assign, getter=isAnimation) BOOL animation;

@end


@interface WJContentView : UIView

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, assign) CGPoint arrowStartPoint;     // 三角形剪头的开始位置

@property (nonatomic, assign) WJPopoverViewControllerArrowDirection arrowType; // 方向

@end


@implementation WJPopoverViewController

#pragma mark - 构建方法
- (instancetype)initWithViewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        self.viewController = viewController;
        self.showView = viewController.view;
        _contentSize = _showView.bounds.size;
        self.cornerRadius = 5;
    }
    return self;
}

+ (instancetype)popViewWithViewController:(UIViewController *)viewController
{
    return [[self alloc] initWithViewController:viewController];
}

- (instancetype)initWithShowView:(UIView *)showView
{
    if (self = [super init]) {
        self.showView = showView;
        _contentSize = _showView.bounds.size;
        self.cornerRadius = 5;
    }
    return self;
}

+ (instancetype)popViewWithShowView:(UIView *)showView
{
    return [[self alloc] initWithShowView:showView];
}

#pragma mark - viewDidLoad
static WJPopoverViewController *instance = nil;
- (void)viewDidLoad
{
    [super viewDidLoad];
    instance = self;
    _alpha = 0.15;
    _customShowAnimation = YES;
    UIControl *cancelControl = [[UIControl alloc] initWithFrame:self.view.bounds];
    cancelControl.backgroundColor = [UIColor blackColor];
    cancelControl.alpha = 0;
    [self.view addSubview:cancelControl];
    [cancelControl addTarget:self action:@selector(cancelPopViewFromSuperView) forControlEvents:UIControlEventTouchDown];
    self.cancelControl = cancelControl;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:WJPopoverViewControllerWillAppearNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:WJPopoverViewControllerDidAppearNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:WJPopoverViewControllerWillDisappearNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:WJPopoverViewControllerDidDisappearNotification object:nil];
}

#pragma mark - view 的移除
- (void)cancelPopViewFromSuperView
{
    [self dissPopoverViewWithAnimation:_animation duration:0.15];
}

- (void)dissPopoverViewWithAnimation:(BOOL)animation duration:(NSTimeInterval)duration
{
    if (animation) {
        [UIView animateWithDuration:duration animations:^{
            self.showView.transform = CGAffineTransformMakeScale(self->_transformScale.x, self->_transformScale.y);
            self.cancelControl.alpha = 0.0001;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
        }];
    } else {
        [self.view removeFromSuperview];
    }
    instance = nil;
}

- (void)dissPopoverViewWithAnimation:(BOOL)animation
{
    [self dissPopoverViewWithAnimation:animation duration:0.15];
}

+ (void)dissPopoverViewWithAnimation:(BOOL)animation
{
    [instance dissPopoverViewWithAnimation:animation duration:0.15];
}

- (void)dissPopoverViewWithAnimationDuration:(NSTimeInterval)duration
{
    [self dissPopoverViewWithAnimation:YES duration:duration];
}

+ (void)dissPopoverViewWithAnimationDuration:(NSTimeInterval)duration
{
    [instance dissPopoverViewWithAnimation:YES duration:duration];
}

#pragma mark - action 展示view
#pragma mark 界面的展示基于普通按钮的触发
- (void)showPopoverWithTouch:(UIEvent *)senderEvent
                   animation:(BOOL)animation
{
    TICK;
    [self showPopoverWithTouch:senderEvent];;
    _animation = animation;
    if (self.isCustomShowAnimation) [self confirmShowAnimation];
    if (animation) [self directionAnimation:_showAnimation];
    TOCK;
}

- (void)showPopoverWithTouch:(UIEvent *)senderEvent
          directionAnimation:(WJPopoverViewShowAnimation)directionAnimation
{
    TICK;
    [self showPopoverWithTouch:senderEvent];
    _animation = YES;
    [self directionAnimation:directionAnimation];
    TOCK;
}

- (void)showPopoverWithTouch:(UIEvent *)senderEvent
{
    UITouch *touch = senderEvent.allTouches.anyObject;
    CGRect senderRect = [touch.view convertRect:touch.view.bounds toView:touch.window];
    if (self.isCustomArrowDirection) {
        [self setContentViewFrameWithRect:senderRect];
    } else {
        [self contentViewShowArrowDirectionWithRect:senderRect];
    }
    [self addContentView];
}

#pragma mark 需要展示的界面是基于UIBarButtonItem
- (void)showPopoverWithBarButtonItemTouch:(UIEvent *)senderEvent
                                animation:(BOOL)animation
{
    TICK;
    [self showPopoverWithBarButtonItemTouch:senderEvent];
    _animation = animation;
    if (self.isCustomShowAnimation) [self confirmShowAnimation];
    if (animation) [self directionAnimation:_showAnimation];
    TOCK;
}


- (void)showPopoverWithBarButtonItemTouch:(UIEvent *)senderEvent
                       directionAnimation:(WJPopoverViewShowAnimation)directionAnimation
{
    TICK;
    [self showPopoverWithBarButtonItemTouch:senderEvent];
    _animation = YES;
    [self directionAnimation:directionAnimation];
    TOCK;
}

- (void)showPopoverWithBarButtonItemTouch:(UIEvent *)senderEvent
{
    UITouch *touch = senderEvent.allTouches.anyObject;
    CGRect senderRect = [touch.view convertRect:touch.view.bounds toView:touch.window];
    senderRect.origin.y = 64 - senderRect.size.height;
    _arrowDirection = WJPopoverViewControllerArrowDirectionBottom;
    [self setContentViewFrameWithRect:senderRect];
    [self addContentView];
}

#pragma mark 需要展示的界面是基于tableviewcell
- (void)showPopoverWithTableView:(UITableViewCell *)tableViewCell
                       animation:(BOOL)animation
{
    [self showPopoverWithTableView:tableViewCell];
    _animation = animation;
    if (self.isCustomShowAnimation) [self confirmShowAnimation];
    if (animation) [self directionAnimation:_showAnimation];
}

- (void)showPopoverWithTableView:(UITableViewCell *)tableViewCell
              directionAnimation:(WJPopoverViewShowAnimation)directionAnimation
{
    [self showPopoverWithTableView:tableViewCell];
    _animation = YES;
    [self directionAnimation:directionAnimation];
}

- (void)showPopoverWithTableView:(UITableViewCell *)tableViewCell
{
    CGRect senderRect = [tableViewCell convertRect:tableViewCell.bounds toView:WJKeyWindow];
    
    if (!self.isCustomArrowDirection) {
        // 重新给cell的frame进行设置，以适应展示
        if (senderRect.size.width / 2 < _contentSize.width + WJArrowHeight) {
            CGFloat temp = senderRect.size.width - _contentSize.width - WJArrowHeight - WJMargin;
            senderRect = CGRectMake(temp > 10 ? temp : 10, senderRect.origin.y, 1, senderRect.size.height);
        } else {
            senderRect = CGRectMake(senderRect.size.width / 2, senderRect.origin.y, 1, senderRect.size.height);
        }
        _arrowDirection = WJPopoverViewControllerArrowDirectionRight;
        [self setContentViewFrameWithRect:senderRect];
    } else {
        [self contentViewShowArrowDirectionWithRect:senderRect];
    }
    
    [self addContentView];
}

#pragma mark 需要展示的界面是基于给定的rect
- (void)showPopoverWithRect:(CGRect)touchRect animation:(BOOL)animation
{
    if (self.isCustomArrowDirection) {
        [self setContentViewFrameWithRect:touchRect];
    } else {
        [self contentViewShowArrowDirectionWithRect:touchRect];
    }
    
    [self addContentView];
    _animation = animation;
    if (self.isCustomShowAnimation) [self confirmShowAnimation];
    if (animation) [self directionAnimation:0];
}

#pragma mark 添加contentview
- (void)addContentView
{
    [self reloadSetShowViewFrame];
    
    WJContentView *contentView = [[WJContentView alloc] initWithFrame:_contentViewFrame];
    contentView.autoresizesSubviews = NO;
    contentView.arrowType = _arrowDirection;
    contentView.arrowStartPoint = _arrowStartPoint;
    contentView.borderColor = _borderColor;
    [contentView addSubview:_showView];
    [self.view insertSubview:contentView belowSubview:self.view];
    
    [WJKeyWindow addSubview:self.view];
}

#pragma mark - 动画设置，基于transform

#pragma mark 确认使用那个动画，在没有选择动画时使用
- (void)confirmShowAnimation
{
    if (_arrowStartPoint.x == 0 || _arrowStartPoint.x == _contentSize.width) {
        if (_arrowStartPoint.y < _contentSize.height / 3) {
            _showAnimation = _arrowStartPoint.x == 0 ? WJPopoverViewShowAnimationTopLeft : WJPopoverViewShowAnimationTopRight;
        }
        else if (_arrowStartPoint.y > _contentSize.height * 2 / 3) {
            _showAnimation = _arrowStartPoint.x == 0 ? WJPopoverViewShowAnimationBottomLeft : WJPopoverViewShowAnimationBottomRight;
        }
        else {
            _showAnimation = _arrowStartPoint.x == 0 ? WJPopoverViewShowAnimationLeftRight : WJPopoverViewShowAnimationRightLeft;
        }
    }
    else if (_arrowStartPoint.y == 0 || _arrowStartPoint.y == _contentSize.height) {
        if (_arrowStartPoint.x < _contentSize.width / 3) {
            _showAnimation = _arrowStartPoint.y == 0 ? WJPopoverViewShowAnimationTopLeft : WJPopoverViewShowAnimationTopRight;
        }
        else if (_arrowStartPoint.x > _contentSize.width * 2 / 3) {
            _showAnimation = _arrowStartPoint.y == 0 ? WJPopoverViewShowAnimationTopRight : WJPopoverViewShowAnimationBottomRight;
        }
        else {
            _showAnimation = _arrowStartPoint.y == 0 ? WJPopoverViewShowAnimationNormal : WJPopoverViewShowAnimationBottomTop;
        }
    }
}

#pragma mark 动画
- (void)directionAnimation:(WJPopoverViewShowAnimation)directionAnimation
{
    CGFloat positionX1 = _arrowDirection == WJPopoverViewControllerArrowDirectionRight ? WJArrowHeight + _showView.bounds.size.width / 2 : _showView.bounds.size.width / 2;
    
    CGFloat positionX2 = _arrowDirection == WJPopoverViewControllerArrowDirectionRight ? WJArrowHeight : 0;
    
    CGFloat positionY1 = _arrowDirection == WJPopoverViewControllerArrowDirectionBottom ? WJArrowHeight : 0;
    
    CGFloat positionY2 = _arrowDirection == WJPopoverViewControllerArrowDirectionTop ? _contentSize.height - WJArrowHeight:  _contentSize.height;
    
    CGFloat positionX3 = _arrowDirection == WJPopoverViewControllerArrowDirectionLeft ? _contentSize.width - WJArrowHeight : _contentSize.width;
    
    CGFloat positionY3 = (_arrowDirection == WJPopoverViewControllerArrowDirectionBottom) ? (_contentSize.height + WJArrowHeight) / 2 : (_arrowDirection == WJPopoverViewControllerArrowDirectionTop) ? (_contentSize.height - WJArrowHeight) / 2 : _contentSize.height / 2;
    
    switch (directionAnimation) {
        case WJPopoverViewShowAnimationNormal:
            _transformScale = CGPointMake(1, 0.0001);
            [self setShowViewTransformWithScale:_transformScale anchorPoint:(CGPoint){0.5, 0} position:(CGPoint){positionX1, positionY1}];
            break;
            
        case WJPopoverViewShowAnimationTopLeft:
            _transformScale = CGPointMake(0.0001, 0.0001);
            [self setShowViewTransformWithScale:_transformScale anchorPoint:(CGPoint){0, 0} position:(CGPoint){positionX2, positionY1}];
            break;
            
        case WJPopoverViewShowAnimationTopRight:
            _transformScale = CGPointMake(0.0001, 0.0001);
            [self setShowViewTransformWithScale:_transformScale anchorPoint:(CGPoint){1, 0} position:(CGPoint){positionX3, positionY1}];
            break;
            
        case WJPopoverViewShowAnimationBottomLeft:
            _transformScale = CGPointMake(0.0001, 0.0001);
            [self setShowViewTransformWithScale:_transformScale anchorPoint:(CGPoint){0, 1} position:(CGPoint){positionX2, positionY2}];
            break;
            
        case WJPopoverViewShowAnimationBottomRight:
            _transformScale = CGPointMake(0.0001, 0.0001);
            [self setShowViewTransformWithScale:_transformScale anchorPoint:(CGPoint){1, 1} position:(CGPoint){positionX3, positionY2}];
            break;
            
        case WJPopoverViewShowAnimationBottomTop:
            _transformScale = CGPointMake(1, 0.0001);
            [self setShowViewTransformWithScale:_transformScale anchorPoint:(CGPoint){0.5, 1} position:(CGPoint){positionX1, positionY2}];
            break;
            
        case WJPopoverViewShowAnimationLeftRight:
            _transformScale = CGPointMake(0.0001, 1);
            [self setShowViewTransformWithScale:_transformScale anchorPoint:(CGPoint){0, 0.5} position:(CGPoint){positionX2, positionY3}];
            break;
            
        case WJPopoverViewShowAnimationRightLeft:
            _transformScale = CGPointMake(0.0001, 1);
            [self setShowViewTransformWithScale:_transformScale anchorPoint:(CGPoint){1, 0.5} position:(CGPoint){positionX3, positionY3}];
            break;
        default:
            break;
    }
    [UIView animateWithDuration:_duration ? : 0.2 animations:^{
        self.showView.transform = CGAffineTransformMakeScale(1, 1);
        self.cancelControl.alpha = self->_alpha;
    }];
}

#pragma mark 设置展示界面的layer
- (void)setShowViewTransformWithScale:(CGPoint)scale
                          anchorPoint:(CGPoint)anchor
                             position:(CGPoint)position
{
    _showView.transform = CGAffineTransformMakeScale(scale.x, scale.y);
    _showView.layer.anchorPoint = CGPointMake(anchor.x, anchor.y);
    _showView.layer.position = CGPointMake(position.x, position.y);
}


#pragma mark contentView 的展示方向
- (void)contentViewShowArrowDirectionWithRect:(CGRect)senderRect
{
    CGFloat senderX = senderRect.origin.x;
    CGFloat senderY = senderRect.origin.y;
    CGFloat senderWidth = senderRect.size.width;
    CGFloat senderHeight = senderRect.size.height;
    
    // 判断是否能在点击的下面显示
    if (WJScreenHeight - (senderY + senderHeight) >= (_contentSize.height + WJArrowHeight)) {
        _arrowDirection = WJPopoverViewControllerArrowDirectionBottom;
    }
    
    // 判断是否能在点击的上面显示
    else if (senderY >= (_contentSize.height + WJArrowHeight + WJStatusBarHeight)) {
        _arrowDirection = WJPopoverViewControllerArrowDirectionTop;
    }
    
    // 判断是否能在点击的左边显示
    else if ((senderRect.origin.x >= (_contentSize.width + WJArrowHeight)) && _contentSize.height <= WJScreenHeight - WJStatusBarHeight) {
        _arrowDirection = WJPopoverViewControllerArrowDirectionLeft;
    }
    // 判断是否能在点击的右边显示
    else if ((WJScreenWidth - (senderX + senderWidth) >= (_contentSize.width + WJArrowHeight)) && _contentSize.height <= WJScreenHeight - WJStatusBarHeight) {
        _arrowDirection = WJPopoverViewControllerArrowDirectionRight;
    }
    // 以上的四种情况都不能满足时，抛出异常crash
    else {
        NSAssert(NO, @"添加的弹出view不能满足四个方向的放置，请缩减宽度或者高度");
    }
    [self setContentViewFrameWithRect:senderRect];
}

#pragma mark contentView 展示在superView上的位置和三角形的开始位置
- (void)setContentViewFrameWithRect:(CGRect)senderRect
{
    CGFloat senderX = senderRect.origin.x;
    CGFloat senderY = senderRect.origin.y;
    CGFloat senderWidth = senderRect.size.width;
    CGFloat senderHeight = senderRect.size.height;
    
    CGFloat startX = 0;
    CGFloat startY = 0;
    
    CGFloat temp = 0;
    
    switch (_arrowDirection) {
        case WJPopoverViewControllerArrowDirectionBottom:
        case WJPopoverViewControllerArrowDirectionTop:
            // 设置开始的Y值
            startY = _arrowDirection == WJPopoverViewControllerArrowDirectionBottom ? senderY + senderHeight : senderY - (_contentSize.height + WJArrowHeight);
            // 确定三角形的开始Y值
            temp = _arrowDirection == WJPopoverViewControllerArrowDirectionBottom ? 0 : _contentSize.height + WJArrowHeight;
            
            // 根据当前点击的位置是在屏幕的左边还是右边确定显示的位置
            if (WJScreenWidth / 2 >= senderX + senderWidth / 2) {
                if ((senderX + senderWidth / 2) >= _contentSize.width / 2) {
                    startX = (senderX + senderWidth / 2) - _contentSize.width / 2;
                    _arrowStartPoint = CGPointMake(_contentSize.width / 2, temp);
                } else {
                    startX = WJMargin;
                    _arrowStartPoint = CGPointMake(senderX + senderWidth / 2, temp);
                }
            } else {
                if (WJScreenWidth - (senderX + senderWidth / 2) >= _contentSize.width / 2) {
                    startX = (senderX + senderWidth / 2) - _contentSize.width / 2;
                    _arrowStartPoint = CGPointMake(_contentSize.width / 2, temp);
                } else {
                    startX = WJScreenWidth - _contentSize.width - WJMargin;
                    _arrowStartPoint = CGPointMake((senderX + senderWidth / 2) - startX, temp);
                }
            }
            _arrowStartPoint.x += _offSet;
            _contentSize.height += WJArrowHeight;
            break;
            
        case WJPopoverViewControllerArrowDirectionLeft:
        case WJPopoverViewControllerArrowDirectionRight:
            startX = _arrowDirection == WJPopoverViewControllerArrowDirectionLeft ? senderX - _contentSize.width - WJArrowHeight : senderX + senderWidth;
            temp = _arrowDirection == WJPopoverViewControllerArrowDirectionLeft ? _contentSize.width + WJArrowHeight : 0;
            if ((WJScreenHeight - WJStatusBarHeight) / 2 >= senderY + senderHeight / 2) {
                if (senderY + senderHeight / 2 >= (_contentSize.height + WJArrowHeight) / 2 + WJStatusBarHeight) {
                    startY = senderY + senderHeight / 2 - (_contentSize.height + WJArrowHeight) / 2;
                    _arrowStartPoint = CGPointMake(temp, (_contentSize.height + WJArrowHeight) / 2);
                } else {
                    startY = WJStatusBarHeight;
                    _arrowStartPoint = CGPointMake(temp, senderY + senderHeight / 2 - startY);
                }
            } else {
                if (WJScreenHeight - (senderY + senderHeight / 2) >= (_contentSize.height + WJArrowHeight) / 2) {
                    startY = senderY + senderHeight / 2 - (_contentSize.height + WJArrowHeight) / 2;
                    _arrowStartPoint = CGPointMake(temp, (_contentSize.height + WJArrowHeight) / 2);
                } else {
                    startY = WJScreenHeight - (_contentSize.height + WJArrowHeight + WJMargin);
                    _arrowStartPoint = CGPointMake(temp, senderY + senderHeight / 2 - startY);
                }
            }
            _arrowStartPoint.y += _offSet;
            _contentSize.width += WJArrowHeight;
            break;
        default:
            break;
    }
    _contentViewFrame = CGRectMake(startX, startY, _contentSize.width, _contentSize.height);
}

#pragma mark 重新设置展示view的位置
- (void)reloadSetShowViewFrame
{
    CGPoint showViewOrigin;
    switch (_arrowDirection) {
        case WJPopoverViewControllerArrowDirectionTop:
        case WJPopoverViewControllerArrowDirectionLeft:
            showViewOrigin = CGPointMake(0, 0);
            break;
            
        case WJPopoverViewControllerArrowDirectionBottom:
        case WJPopoverViewControllerArrowDirectionRight:
            showViewOrigin = CGPointMake(0, WJArrowHeight);
            break;
        default:
            break;
    }
    CGRect showViewRect = _showView.frame;
    showViewRect.origin = showViewOrigin;
    _showView.frame = showViewRect;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

#pragma mark - 数据加载
- (void)setViewController:(UIViewController *)viewController
{
    _viewController = viewController;
    self.showView = viewController.view;
    self.contentSize = self.showView.bounds.size;
    self.cornerRadius = 5;
}

- (void)setShowView:(UIView *)showView
{
    _showView = showView;
    self.contentSize = self.showView.bounds.size;
    self.cornerRadius = 5;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    _showView.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    _showView.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    _showView.layer.cornerRadius = cornerRadius;
    _showView.layer.masksToBounds = YES;
}

- (void)setArrowDirection:(WJPopoverViewControllerArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    _customArrowDirection = YES;
}

- (void)setPositionDirection:(WJPopoverViewControllerCellPosition)positionDirection
{
    _positionDirection = positionDirection;
    _customArrowDirection = !positionDirection;
}

- (void)setShowAnimation:(WJPopoverViewShowAnimation)showAnimation
{
    _showAnimation = showAnimation;
    _customShowAnimation = NO;
}

@end


#pragma mark - WJContentView 画三角形

@implementation WJContentView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_arrowStartPoint];
    if (_arrowType == WJPopoverViewControllerArrowDirectionTop) {
        [path addLineToPoint:(CGPoint){_arrowStartPoint.x + 8, rect.size.height - WJArrowHeight}];
        [path addLineToPoint:(CGPoint){_arrowStartPoint.x - 8, rect.size.height - WJArrowHeight}];
    }
    
    else if (_arrowType == WJPopoverViewControllerArrowDirectionBottom) {
        [path addLineToPoint:(CGPoint){_arrowStartPoint.x + 8, WJArrowHeight}];
        [path addLineToPoint:(CGPoint){_arrowStartPoint.x - 8, WJArrowHeight}];
    }
    
    else if (_arrowType == WJPopoverViewControllerArrowDirectionLeft) {
        [path addLineToPoint:(CGPoint){rect.size.width - WJArrowHeight, _arrowStartPoint.y + 8}];
        [path addLineToPoint:(CGPoint){rect.size.width - WJArrowHeight, _arrowStartPoint.y - 8}];
    }
    
    else {
        [path addLineToPoint:(CGPoint){WJArrowHeight, _arrowStartPoint.y + 8}];
        [path addLineToPoint:(CGPoint){WJArrowHeight, _arrowStartPoint.y - 8}];
    }
    
    [path addLineToPoint:_arrowStartPoint];
    [_borderColor ? : [UIColor whiteColor] setFill];
    [path fill];
}

@end
























