//
//  LWHFirstViewController.m
//  LWHTestOne
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import "LWHFirstViewController.h"
#import "UIImage+Category.h"
#import "BaseNaviController.h"
#import "LWHWalletViewController.h"
@interface LWHFirstViewController ()

@end

@implementation LWHFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenReturnButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//
//    }]];
    
    
    UIButton *Button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [Button setTitle:@"Push" forState:(UIControlStateNormal)];
    [Button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//    [Button addTarget:self action:@selector(ButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    Button.titleLabel.font = [UIFont systemFontOfSize:TextFont];
    Button.layer.masksToBounds = YES;
    Button.layer.cornerRadius = 5;
    Button.backgroundColor = [UIColor redColor];
    Button.width = 100;
    Button.height = 40;
    Button.centerX = self.view.centerX;
    Button.centerY  = self.view.centerY;
    [self.view addSubview:Button];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:Button.frame];
    imageView.backgroundColor = [UIColor redColor];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
//    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//
//    }]];
    
    UIView *viewOne = [[UIView alloc]initWithFrame:Button.frame];
    viewOne.backgroundColor = [UIColor blueColor];
    viewOne.userInteractionEnabled = YES;
//    [viewOne addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
//
//    }]];
    [self.view addSubview:viewOne];
}
//-(void)ButtonAction{
//    LWHWalletViewController *VC = [[LWHWalletViewController alloc]init];
//    [self.navigationController pushViewController:VC animated:YES];
//}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//
//}

@end
