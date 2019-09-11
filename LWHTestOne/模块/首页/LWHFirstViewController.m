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
    UIButton *Button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [Button setTitle:@"Push" forState:(UIControlStateNormal)];
    [Button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [Button addTarget:self action:@selector(ButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    Button.titleLabel.font = [UIFont systemFontOfSize:TextFont];
    Button.layer.masksToBounds = YES;
    Button.layer.cornerRadius = 5;
    Button.backgroundColor = [UIColor redColor];
    [self.view addSubview:Button];
    Button.width = 100;
    Button.height = 40;
    Button.centerX = self.view.centerX;
    Button.centerY  = self.view.centerY;
    
    
    
}
-(void)ButtonAction{
    LWHSwiftViewController *swiftVC = [[LWHSwiftViewController alloc]init];
    [self.navigationController pushViewController:swiftVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
