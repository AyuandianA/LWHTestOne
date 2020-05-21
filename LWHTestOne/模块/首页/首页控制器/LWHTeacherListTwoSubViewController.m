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
        __weak typeof(self)weakSelf = self;
        _tableView = [LWHPublicTableView creatPublicTableViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - TopHeight  - BottomHeight) style:(UITableViewStylePlain)];
        _tableView.cellName = @"LWHTescherListTwoTableViewCell";
        _tableView.tapSection = ^(NSIndexPath *indexPath) {
            
        };
        _tableView.scrollSection = ^(void) {
            [weakSelf scrolling];
        };
    }
    return _tableView;
}

//一旦属性被操作了，这里会自动响应（上面设置观察的属性才会在这响应）
- (void)scrolling {
    if (!self.canScroll) {
        self.tableView.contentOffset = CGPointZero;
    }
    if (self.tableView.contentOffset.y <= 0) {
        self.canScroll = NO;
        self.tableView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"adsfsdfasdf" object:nil];
    }
}



@end
