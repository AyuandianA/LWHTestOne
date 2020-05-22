//
//  LWHPublicViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/22.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHPublicViewController.h"
#import "BaseNaviController.h"
@interface LWHPublicViewController ()
@end

@implementation LWHPublicViewController
#pragma mark 视图已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建控件
    [self ControllerKongJianBuJu];
}
#pragma mark 创建控件
-(void)ControllerKongJianBuJu
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

-(LWHPublicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [LWHPublicTableView creatPublicTableViewWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.cellName = @"LWHPublicTableViewCell";
        
    }
    return _tableView;
}
@end
