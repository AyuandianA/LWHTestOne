//
//  LWHPublicViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/22.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHPublicViewController.h"
#import "BaseNaviController.h"
#import "LWHPublicTableView.h"
@interface LWHPublicViewController ()
@property (nonatomic,strong) LWHPublicTableView *tableView;
@end

@implementation LWHPublicViewController
#pragma mark 视图已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建控件
    [self ControllerKongJianBuJu];
    //获取数据源
    [self getDataSources];
}
#pragma mark 创建控件
-(void)ControllerKongJianBuJu
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.hidden = YES;
    
    [self.view addSubview:self.tableView];
}

#pragma mark 获取数据源
-(void)getDataSources
{
    for (int i = 0; i < 20; i++) {
        [self.tableView.PublicSourceArray addObject:@{@"time":@"2020-03-30 13：55：33",@"title":@"四库国学之奇门遁甲课程"}];
    }
    [self.tableView reloadData];
}

-(LWHPublicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [LWHPublicTableView creatPublicTableViewWithFrame:CGRectMake(0, TopHeight , KScreenWidth,KScreenHeight - TopHeight - BottomHeight) style:(UITableViewStyleGrouped)];
        _tableView.cellName = @"LWHPublicTableViewCell";
        
    }
    return _tableView;
}
@end
