//
//  LWHTeacherListTwoSubViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/21.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHPublicBaseTwoViewController.h"

@interface LWHPublicBaseTwoViewController ()
@end

@implementation LWHPublicBaseTwoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建控件
        [self ControllerKongJianBuJu];
    }
    return self;
}
#pragma mark 创建控件
-(void)ControllerKongJianBuJu
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    __weak typeof(self)weakSelf = self;
    self.tableView.scrollSection = ^(void) {
        [weakSelf scrolling];
    };
}

-(LWHPublicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [LWHPublicTableView creatPublicTableViewWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.cellName = @"LWHPublicTableViewCell";
        
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
