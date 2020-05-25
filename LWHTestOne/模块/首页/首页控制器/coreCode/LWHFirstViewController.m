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
#import "LWHPublicBaseUseViewController.h"
@interface LWHFirstViewController ()
//展示列表
@end

@implementation LWHFirstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.hidden = YES;
    
    LWHPublicBaseUseViewController *baseCtro = [[LWHPublicBaseUseViewController alloc]init];
    [self.navigationController pushViewController:baseCtro animated:YES];
}



@end
