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
#import "LWHScrollViewOne.h"


@interface LWHFirstViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
//展示列表
@property (nonatomic,strong) UITableView *tableView;
//表视图数据源
@property (nonatomic,strong) NSMutableArray *dataArray;
//表视图头视图
@property (nonatomic,strong) UIView *headerView;
//轮播图背景滚动图
@property (nonatomic,strong) LWHScrollViewOne *sdchcleView;
@end

@implementation LWHFirstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenReturnButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    
    //头视图
    self.headerView = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 300)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    //图片滚动视图
    self.sdchcleView = [[LWHScrollViewOne alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 100) andImagesScaleArray:@[@(366.0/638),@(626.0/636),@(1092.0/642),@(366.0/638)] andImagesNameArray:@[@"1",@"2",@"3",@"1"]];
    [self.headerView addSubview:self.sdchcleView];
    //医生说文字内容
    UILabel *contentLable = [[UILabel alloc]init];
    contentLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    contentLable.textColor = [UIColor blackColor];
    contentLable.frame = CGRectMake(10, self.sdchcleView.bottom+ 10, KScreenWidth - 2 * 10, 100);
    contentLable.text = @"咳嗽赶紧好吧";
    [self.headerView addSubview:contentLable];
    self.headerView.height = contentLable.bottom;
    //列表视图
    UITableView *tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    self.tableView.frame = CGRectMake(0, TopHeight, KScreenWidth, KScreenHeight - TopHeight - BottomHeight);
    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    //计算各视图frame
    __weak typeof(self) weakSelf = self;
    self.sdchcleView.heightChange = ^(CGFloat height) {
        contentLable.top = height + 10;
        weakSelf.headerView.height = contentLable.bottom;
        [weakSelf.tableView setTableHeaderView:weakSelf.headerView];
    };
}







@end
