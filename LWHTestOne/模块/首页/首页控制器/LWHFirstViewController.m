//
//  LWHFirstViewController.m
//  LWHTestOne
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import "LWHFirstViewController.h"
#import "BaseNaviController.h"
#import "UIImage+Category.h"
#import "UIImage+Category.h"
#import "LWHTarbarView.h"
@interface LWHFirstViewController ()

@end

@implementation LWHFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenReturnButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat widthTabbar = UIScreen.mainScreen.bounds.size.width / 5.0;
    LWHTarbarView *tarbar = [[LWHTarbarView alloc]initWithFrame:CGRectMake(widthTabbar * 2, 200, 100, 100)];
    [self.view addSubview:tarbar];
    [tarbar.arcView.tapButton addTarget:self action:@selector(tapBarButton) forControlEvents:(UIControlEventTouchUpInside)];
}
//swift混编
//-(void)tapBarButton{
//    LWHSwiftViewController *VC = [[LWHSwiftViewController alloc]init];
//    [self.navigationController pushViewController:VC animated:YES];
//}
-(void)tapBarButton{
    
}

@end
