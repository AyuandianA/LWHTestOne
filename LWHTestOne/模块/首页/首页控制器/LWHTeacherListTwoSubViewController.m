//
//  LWHTeacherListTwoSubViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/21.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHTeacherListTwoSubViewController.h"
#import "LWHTeacherListTwoModel.h"
@interface LWHTeacherListTwoSubViewController ()

@end

@implementation LWHTeacherListTwoSubViewController
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
    AdjustsScrollViewInsetNever(self, self.tableView);
    for (int i = 0; i < 20; i++) {
        LWHTeacherListTwoModel *model = [LWHTeacherListTwoModel modelWithDictionary:@{@"q":@"q",@"a":@"q"}];
        [self.tableView.PublicSourceArray addObject:model];
    }
    [self.tableView reloadData];
}

-(LWHPublicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [LWHPublicTableView creatPublicTableViewWithFrame:CGRectMake(0, TopHeight + 50, KScreenWidth, KScreenHeight - TopHeight - 50) style:(UITableViewStylePlain)];
        _tableView.cellName = @"LWHTescherListTwoTableViewCell";
        _tableView.tapSection = ^(NSIndexPath *indexPath) {
            
        };
    }
    return _tableView;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.canScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"adsfsdfasdf" object:nil];
    }
}
@end
