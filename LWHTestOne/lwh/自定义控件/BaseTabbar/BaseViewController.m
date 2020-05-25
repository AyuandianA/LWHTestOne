//
//  BaseViewController.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/7.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Category.h"
#import "LSNavigationController.h"

@interface BaseViewController ()

@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation BaseViewController

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-64*2, 44)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:((KScreenWidth > 375) ? 18 : (KScreenWidth > 320) ? 16 : 15)];
    }
    return _titleLabel;
}

- (UIButton *)leftBtn {
    
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]init];
        _leftBtn.frame = CGRectMake(0, 0, 60, 44);
        [_leftBtn setImage:[UIImage imageNamed:@"left_return_white"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"left_return_white"] forState:UIControlStateHighlighted];
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(9.5f, 10, 9.5f, 25);
        [_leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self reloadNavigationBar];
    
//    [[IQKeyboardManager sharedManager] setEnable:NO];
//
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationBar setShadowImage:[UIImage new]];
    
    // 设置导航栏字体
    NSDictionary *attributesDic = @{
                                    NSForegroundColorAttributeName:[UIColor whiteColor],
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:17]
                                    };
    
    self.navigationBar.titleTextAttributes = attributesDic;
    
    [self.navigationBar setBackgroundImage:[UIImage convertViewToImage] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    
    self.navigationItem.titleView = self.titleLabel;
   
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;

}
- (void)setNaviTitleColor:(UIColor *)naviTitleColor {
    self.titleLabel.textColor = naviTitleColor;
}
- (void)setIsHiddenReturnButton:(BOOL)isHiddenReturnButton {

    if (isHiddenReturnButton) {
//        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    }
    [self.view layoutIfNeeded];

}
- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (void)setTitleString:(NSString *)titleString {
//
//    _titleString = titleString;
//
//    self.titleLabel.text = _titleString;
//
//}
- (void)injected{
    NSLog(@"I've been injected: %@", self);
    [self viewDidLoad];
}

@end
