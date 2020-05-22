//
//  LWHSouSuoCourseViewController.m
//  zhibo
//
//  Created by 李武华 on 2020/5/22.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHSouSuoCourseViewController.h"
#import "BaseNaviController.h"
#import "LWHPublicTableView.h"
@interface LWHSouSuoCourseViewController ()
@property (nonatomic,strong) LWHPublicTableView *tableView;
@end

@implementation LWHSouSuoCourseViewController
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
        [self.tableView.PublicSourceArray addObject:@[@{@"time":@"2020-03-30 13：55：33",@"title":@"四库国学之奇门遁甲课程"},@{@"time":@"2020-03-30 13：55：33",@"title":@"四库国学之奇门遁甲课程"},@{@"time":@"2020-03-30 13：55：33",@"title":@"四库国学之奇门遁甲课程"},@{@"time":@"2020-03-30 13：55：33",@"title":@"四库国学之奇门遁甲课程"},@{@"time":@"2020-03-30 13：55：33",@"title":@"四库国学之奇门遁甲课程"},@{@"time":@"2020-03-30 13：55：33",@"title":@"四库国学之奇门遁甲课程"}]];
    }
    [self.tableView reloadData];
}

-(LWHPublicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [LWHPublicTableView creatPublicTableViewWithFrame:CGRectMake(0, TopHeight , KScreenWidth,KScreenHeight - TopHeight - BottomHeight) style:(UITableViewStyleGrouped)];
        _tableView.cellName = @"LWHSouSuoCourseTableViewCell";
        
        __weak typeof(self)weakSelf = self;
        _tableView.cellSections = ^NSInteger{
            return 2;
        };
        _tableView.cellRows = ^NSInteger(NSInteger section) {
            return [weakSelf.tableView.PublicSourceArray[section] count];
        };
        _tableView.headerView = ^UIView *(NSInteger section) {
            UIView *view = [[UIView alloc]init];
            UIView *viewOne = [[UIView alloc]initWithFrame:CGRectMake(10, 5, 1.5, 30)];
            viewOne.backgroundColor = [UIColor blueColor];
            [view addSubview:viewOne];
            UILabel *lable = [[UILabel alloc]init];
            lable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
            lable.textColor = [UIColor colorWithWhite:0 alpha:1];
            if (section == 0) {
                lable.text = @"语音直播";
            }else{
                lable.text = @"视频直播";
            }
            [view addSubview:lable];
            lable.frame = CGRectMake(viewOne.right + 10, 5, 100, 30);
            lable.textAlignment = NSTextAlignmentLeft;
          return view;
        };
        _tableView.headerHeight = ^CGFloat(NSInteger section) {
          return 40;
        };
        _tableView.footerView = ^UIView *(NSInteger section) {
            UIView *view = [UIView new];
            UILabel *lable = [[UILabel alloc]init];
            lable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
            lable.frame = CGRectMake(10, 0, KScreenWidth - 20, 40);
            lable.textAlignment = NSTextAlignmentLeft;
            lable.textColor = [UIColor redColor];
            if (section == 0) {
                lable.text = @"更多语音直播";
            }else{
                lable.text = @"更多视频直播";
            }
            lable.userInteractionEnabled = YES;
            [lable addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                NSLog(@"%ld",(long)section);
            }]];
            [view addSubview:lable];
          return view;
        };
        _tableView.footerHeight = ^CGFloat(NSInteger section) {
          return 40;
        };
        _tableView.tapSection = ^(NSIndexPath *indexPath) {

        };
    }
    return _tableView;
}
@end
