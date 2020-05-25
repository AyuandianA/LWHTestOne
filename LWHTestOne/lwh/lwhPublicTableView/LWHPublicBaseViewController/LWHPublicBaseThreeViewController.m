//
//  LWHPublicBaseThreeViewController.m
//  zhibo
//
//  Created by 李武华 on 2020/5/26.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHPublicBaseThreeViewController.h"

@interface LWHPublicBaseThreeViewController ()

@end

@implementation LWHPublicBaseThreeViewController

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

-(LWHPublicCollectionView *)tableView
{
    if (!_tableView) {
        _tableView = [LWHPublicCollectionView creatPublicCollectionViewWithFrame:self.view.bounds];
        _tableView.cellName = @"LWHPublicCollectionViewCell";
        
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
