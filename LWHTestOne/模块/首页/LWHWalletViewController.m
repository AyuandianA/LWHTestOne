//
//  LWHWalletViewController.m
//  LWHTestOne
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import "LWHWalletViewController.h"
#import "BaseNaviController.h"
#import "LWHWalletHeaderView.h"

@interface LWHWalletViewController ()
@property (nonatomic,strong) LWHWalletHeaderViewModel *viewModel;
@property (nonatomic,strong) LWHWalletHeaderView *headerView;
@end

@implementation LWHWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包";
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
    
    [self.view addSubview:self.headerView];
    
    __weak typeof(self)weakSelf = self;
    [self.viewModel getModelUseingUrlstring:User_Account_Index params:@{} Block:^{
        weakSelf.headerView.WalletHeaderViewModel = weakSelf.viewModel;
    }];
    
    
}
-(LWHWalletHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [LWHWalletHeaderView standardWalletHeaderViewWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _headerView;
}
-(LWHWalletHeaderViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel =  [[LWHWalletHeaderViewModel alloc]init];
    }
    return _viewModel;
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
