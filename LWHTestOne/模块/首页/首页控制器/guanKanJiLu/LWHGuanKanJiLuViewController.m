//
//  LWHGuanKanJiLuViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHGuanKanJiLuViewController.h"

@interface LWHGuanKanJiLuViewController ()

@end

@implementation LWHGuanKanJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"观看记录";
    self.tableView.frame = CGRectMake(0, TopHeight, KScreenWidth, KScreenHeight - TopHeight);
    self.tableView.cellName = @"LWHGuanKanJiLuTableViewCell";
    //获取数据源
    [self getDataSources];
}

#pragma mark 获取数据源
-(void)getDataSources
{
    for (int i = 0; i < 10; i++) {
        [self.tableView.PublicSourceArray addObject:@{@"time":@"2020-03-30 13：55：33",@"title":@"四库国学之奇门遁甲课程"}];
    }
    [self.tableView reloadData];
}
@end
