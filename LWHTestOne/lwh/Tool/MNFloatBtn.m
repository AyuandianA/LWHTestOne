//
//  MNAssistiveBtn.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/8/24.
//  Copyright © 2019 WuHua . All rights reserved.
//


#import "MNFloatBtn.h"
#import "UIButton+ImageTitleSpacing.h"
//#import "NSDate+MNDate.h"

#define kSystemKeyboardWindowLevel 10000000

@interface MNFloatBtn()
//悬浮的按钮
@property (nonatomic, strong) MNFloatContentBtn *floatBtn;

@end

@implementation MNFloatBtn {
    //拖动按钮的起始坐标点
    CGPoint _touchPoint;
    
    //起始按钮的x,y值
    CGFloat _touchBtnX;
    CGFloat _touchBtnY;

}

//static
static MNFloatBtn *_floatWindow;

static CGFloat floatBtnW = 60;
static CGFloat floatBtnH = 100;

- (MNFloatContentBtn *)floatBtn {
    if (!_floatBtn) {
        
        _floatBtn = [[MNFloatContentBtn alloc]init];
        _floatBtn.isShow = NO;
        //添加到window上
        [_floatWindow addSubview:_floatBtn];
        _floatBtn.frame = _floatWindow.bounds;
       
    }
    return _floatBtn;
}

#pragma mark - public Method
+ (UIButton *)sharedBtn {
    
    return _floatWindow.floatBtn;
}
+ (void)releaseBtn {
    
    _floatWindow.floatBtn = nil;
    
    _floatWindow = nil;
    
}
+ (void)show {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _floatWindow = [[MNFloatBtn alloc] initWithFrame:CGRectZero];
        _floatWindow.rootViewController = [[UIViewController alloc]init];
        [_floatWindow p_createFloatBtn];
    });
    
    [_floatWindow show];
}
+(void)closeUserInteractionEnabled
{
    _floatWindow.userInteractionEnabled = NO;
}

+(void)showUserInteractionEnabled
{
    _floatWindow.userInteractionEnabled = YES;
}
+ (BOOL)hiddenStatue {
    return _floatWindow.hidden;
}
+ (void)hidden {
    
    [_floatWindow setHidden:YES];
}



#pragma mark - private Method
- (void)show {
    
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    if (_floatWindow.hidden) {
        _floatWindow.hidden = NO;
    }
    else if (!_floatWindow) {
        _floatWindow = [[MNFloatBtn alloc] initWithFrame:CGRectZero];
        _floatWindow.rootViewController = [UIViewController new];
    }
    
    _floatWindow.backgroundColor = [UIColor clearColor];
    [_floatWindow makeKeyAndVisible];
    _floatWindow.windowLevel = kSystemKeyboardWindowLevel;
    
    [currentKeyWindow makeKeyWindow];
    
}

+(CGRect)getFrame {
    
    return _floatWindow.frame;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        CGFloat floatBtnX = kScreenWidth - floatBtnW - 10;
        CGFloat floatBtnY = 60;
        
        frame = CGRectMake(floatBtnX, floatBtnY, floatBtnW, floatBtnH);
        self.frame = frame;
    }
    return self;
}

- (void)p_createFloatBtn{
    self.floatBtn.hidden = NO;
}




#pragma mark - button move
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    //按钮刚按下的时候，获取此时的起始坐标
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
    
    _touchBtnX = self.frame.origin.x;
    _touchBtnY = self.frame.origin.y;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    
    //偏移量(当前坐标 - 起始坐标 = 偏移量)
    CGFloat offsetX = currentPosition.x - _touchPoint.x;
    CGFloat offsetY = currentPosition.y - _touchPoint.y;
    
    //移动后的按钮中心坐标
    CGFloat centerX = self.center.x + offsetX;
    CGFloat centerY = self.center.y + offsetY;
    self.center = CGPointMake(centerX, centerY);
    
    //父试图的宽高
    CGFloat superViewWidth = kScreenWidth;
    CGFloat superViewHeight = kScreenHeight;
    CGFloat btnX = self.frame.origin.x;
    CGFloat btnY = self.frame.origin.y;
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.frame.size.height;
    
    //x轴左右极限坐标
    if (btnX > superViewWidth){
        //按钮右侧越界
        CGFloat centerX = superViewWidth - btnW/2;
        self.center = CGPointMake(centerX, centerY);
    }else if (btnX < 0){
        //按钮左侧越界
        CGFloat centerX = btnW * 0.5;
        self.center = CGPointMake(centerX, centerY);
    }
    
    //默认都是有导航条的，有导航条的，父试图高度就要被导航条占据，固高度不够
    CGFloat defaultNaviHeight = 64;
    CGFloat judgeSuperViewHeight = superViewHeight - defaultNaviHeight;
    
    //y轴上下极限坐标
    if (btnY <= 0){
        //按钮顶部越界
        centerY = btnH * 0.7;
        self.center = CGPointMake(centerX, centerY);
    }
    else if (btnY > judgeSuperViewHeight){
        //按钮底部越界
        CGFloat y = superViewHeight - btnH * 0.5;
        self.center = CGPointMake(btnX, y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGFloat btnY = self.frame.origin.y;
    CGFloat btnX = self.frame.origin.x;
    
    CGFloat minDistance = 2;
    
    //结束move的时候，计算移动的距离是>最低要求，如果没有，就调用按钮点击事件
    BOOL isOverX = fabs(btnX - _touchBtnX) > minDistance;
    BOOL isOverY = fabs(btnY - _touchBtnY) > minDistance;
    
    if (isOverX || isOverY) {
        //超过移动范围就不响应点击 - 只做移动操作
//        NSLog(@"move - btn");
        [self touchesCancelled:touches withEvent:event];
    }else{
        [super touchesEnded:touches withEvent:event];
        
        if (_floatBtn.btnClick) {
            _floatBtn.btnClick(_floatBtn);
        }
    }
   
    //自动识别贴边
    if (self.center.x >= kScreenWidth/2) {

        [UIView animateWithDuration:0.5 animations:^{
            //按钮靠右自动吸边
            CGFloat btnX = kScreenWidth - floatBtnW - 10;
            self.frame = CGRectMake(btnX, btnY, floatBtnW, floatBtnH);
        }];
    }else{

        [UIView animateWithDuration:0.5 animations:^{
            //按钮靠左吸边
            CGFloat btnX = 10;
            self.frame = CGRectMake(btnX, btnY, floatBtnW, floatBtnH);
        }];
    }
    
    
}




@end

@interface MNFloatContentBtn()

@end

@implementation MNFloatContentBtn

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = MainBackColor.CGColor;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        //UIbutton的换行显示
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitle:@"12:33" forState:UIControlStateNormal];
        [self setTitleColor:MainTopColor forState:UIControlStateNormal];
        [self setImage:BundleTabeImage(@"network_phone.png") forState:UIControlStateNormal];
        [self layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:15];

    }
    return self;
}

- (void)setCurrentTime:(NSString *)time {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setTitle:time forState:UIControlStateNormal];
    });
    
}

@end
