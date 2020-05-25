//
//  LWHCourseContentViewController.m
//  zhibo
//
//  Created by 李武华 on 2020/5/24.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHPublicBaseUseViewController.h"
#import "SGPagingView.h"
#import "LWHPublicBaseTwoViewController.h"
#import "LWHPublicBaseThreeViewController.h"
@interface LWHPublicBaseUseViewController ()

@end
@implementation LWHPublicBaseUseViewController
#pragma mark 视图已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitleClassViewAndSgscrollView];
}
-(void)creatTitleClassViewAndSgscrollView
{
    SGPageTitleViewConfigure *configure1 = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure1.titleFont = [UIFont systemFontOfSize:TextFont+3];
    configure1.titleGradientEffect = YES;
    configure1.showBottomSeparator = YES;
    configure1.titleSelectedFont = [UIFont boldSystemFontOfSize:TextFont+3];
    configure1.titleColor = [UIColor blackColor];
    configure1.titleSelectedColor = MainTopColor;
    configure1.indicatorColor = MainTopColor;
    configure1.indicatorToBottomDistance = 0;
    configure1.indicatorHeight = 1.5;
    configure1.indicatorFixedWidth = (KScreenWidth - 20) / 2.0;
    configure1.indicatorStyle = SGIndicatorStyleFixed;
    configure1.bottomSeparatorColor = [UIColor colorWithWhite:0.8 alpha:0.9];

    self.titleClassView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 50) delegate:nil titleNames:@[@"全部课程",@"讲师介绍"] configure:configure1];
    self.titleClassView.selectedIndex = 0;

    LWHPublicBaseTwoViewController *subCtr = [[LWHPublicBaseTwoViewController  alloc]init];
    subCtr.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - TopHeight  - BottomHeight);
    subCtr.tableView.cellName = @"LWHGuanKanJiLuTableViewCell";
    [subCtr.tableView.PublicSourceArray addObject:@[@{},@{},@{}]];
    [subCtr.tableView.PublicSourceArray addObject:@[@{},@{},@{}]];
    [subCtr.tableView.PublicSourceArray addObject:@[@{},@{},@{}]];
    [subCtr.tableView reloadData];
    [self.contArray addObject: subCtr];
    
    LWHPublicBaseThreeViewController *subCtr2 = [[LWHPublicBaseThreeViewController  alloc]init];
    subCtr2.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - TopHeight );
    subCtr2.tableView.cellName = @"LWHSongLiWuCollectionViewCell";
    [subCtr2.tableView.PublicSourceArray addObjectsFromArray:@[@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}]];
    [subCtr2.tableView reloadData];
    [self.contArray addObject: subCtr2];
    
    self.sgscrollView = [[SGPageContentScrollView  alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth  , self.tableView.height - 50) parentVC:self childVCs:self.contArray];
    self.sgscrollView.isAnimated = YES;
    [self.sgscrollView setPageContentScrollViewCurrentIndex:0];
}
-(void)havendButtonAction
{

}
@end
