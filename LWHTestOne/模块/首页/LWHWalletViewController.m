//
//  LWHWalletViewController.m
//  LWHTestOne
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import "LWHWalletViewController.h"
#import "UIImage+Category.h"
#import "BaseNaviController.h"

@interface LWHWalletViewController ()

@end

@implementation LWHWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包";
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(0, 0, self.view.width, 400);
    imageView.image = [UIImage convertViewToImage];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.layer.cornerRadius = 5;
    [self.view addSubview:imageView];
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
