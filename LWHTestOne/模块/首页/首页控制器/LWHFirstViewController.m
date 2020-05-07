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


@interface LWHFirstViewController ()<UIScrollViewDelegate>
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
    
    [self.view addSubview:self.headerView];
    self.sdchcleView = [[LWHScrollViewOne alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 100) andImagesScaleArray:@[@(366.0/638),@(626.0/636),@(1092.0/642)] andImagesNameArray:@[@"1",@"2",@"3"]];
    __weak typeof(self) weakSelf = self;
    self.sdchcleView.heightChange = ^(CGFloat height) {
        weakSelf.headerView.height = height + 100;
    };
    [self.headerView addSubview:self.sdchcleView];
}

-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView  alloc]initWithFrame:CGRectMake(0, 100, KScreenWidth, 300)];
        _headerView.backgroundColor = [UIColor blueColor];
        
    }
    return _headerView;
}





@end
