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
#import "Masonry.h"
@interface LWHFirstViewController ()

@property (nonatomic,strong) UITextField *friendField;
@end

@implementation LWHFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenReturnButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *Button = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [Button setTitle:@"Push" forState:(UIControlStateNormal)];
//    [Button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//    [Button addTarget:self action:@selector(ButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
//    Button.titleLabel.font = [UIFont systemFontOfSize:TextFont];
//    Button.layer.masksToBounds = YES;
//    Button.layer.cornerRadius = 5;
//    Button.backgroundColor = [UIColor redColor];
//    [self.view addSubview:Button];
//    Button.width = 100;
//    Button.height = 40;
//    Button.centerX = self.view.centerX;
//    Button.centerY  = self.view.centerY;
    
    UILabel *friendLable = [[UILabel alloc]initWithFrame:CGRectMake(0, NaviH + StatusHeight + 20, KScreenWidth, 40)];
        friendLable.text = @"请问你最想见谁？";
        friendLable.textColor = [UIColor blueColor];
        friendLable.font = [UIFont systemFontOfSize:22];
    friendLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:friendLable];
        
        UITextField *friendField = [[UITextField alloc]initWithFrame:CGRectMake(0, NaviH + StatusHeight + 50, KScreenWidth, 40)];
        self.friendField = friendField;
        friendField.placeholder = @"请输入姓名";
    friendField.textAlignment = NSTextAlignmentCenter;
        friendField.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:friendField];
        
        UIButton *friendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [friendButton setTitle:@"确定" forState:(UIControlStateNormal)];
        [friendButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [friendButton setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        [friendButton addTarget:self action:@selector(friendButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        friendButton.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        friendButton.layer.masksToBounds = YES;
        friendButton.layer.cornerRadius = 5;
        friendButton.frame = CGRectMake(0, NaviH + StatusHeight + 20 + 100, KScreenWidth, 40);
        [self.view addSubview:friendButton];
        
        
    }
    -(void)friendButtonAction
    {
        if ([self.friendField.text isEqualToString:@"夏美女"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"恭喜你答对了！！！" preferredStyle:UIAlertControllerStyleAlert];
            //添加确定到UIAlertController中
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            } ];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"错误" preferredStyle:UIAlertControllerStyleAlert];
            //添加确定到UIAlertController中
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            } ];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
-(void)ButtonAction{
    LWHSwiftViewController *swiftVC = [[LWHSwiftViewController alloc]init];
    [self.navigationController pushViewController:swiftVC animated:YES];
}

@end
