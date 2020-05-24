//
//  LWHVIPFuWuViewController.m
//  zhibo
//
//  Created by 李武华 on 2020/5/22.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHVIPFuWuViewController.h"

@interface LWHVIPFuWuViewController ()

@end

@implementation LWHVIPFuWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.hidden = YES;
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.tableView.cellName = @"LWHVIPFuWuTableViewCell";
    //添加头视图
    [self addtableHeaderView];
    //获取数据源
    [self getDataSources];
}
-(void)addtableHeaderView
{
    CGFloat margin = 10;
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, 60, 60)];
    [topImageView setImage:[UIImage imageNamed:@"VIPTopView"]];
    [headerView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView);
        make.left.right.equalTo(headerView);
        make.height.mas_equalTo(KScreenWidth *  0.65);
    }];
    
    UILabel *leftLable = [[UILabel alloc]init];
    leftLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    leftLable.textColor = [UIColor colorWithWhite:0.15 alpha:1];
    leftLable.textAlignment = NSTextAlignmentCenter;
    leftLable.numberOfLines = 0;
    leftLable.preferredMaxLayoutWidth = KScreenWidth / 3.0;
    [leftLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    leftLable.text = @"等级名称";
    [headerView addSubview:leftLable];
    [leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(margin  * 2);
        make.left.equalTo(headerView);
        make.width.mas_equalTo(KScreenWidth / 3.0);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *centerLable = [[UILabel alloc]init];
    centerLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    centerLable.textColor = [UIColor colorWithWhite:0.15 alpha:1];
    centerLable.textAlignment = NSTextAlignmentCenter;
    centerLable.numberOfLines = 0;
    centerLable.preferredMaxLayoutWidth = KScreenWidth / 3.0;
    [centerLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    centerLable.text = @"购买课程折扣";
    [headerView addSubview:centerLable];
    [centerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(margin  * 2);
        make.left.equalTo(leftLable.mas_right);
        make.width.mas_equalTo(KScreenWidth / 3.0);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *rightLable = [[UILabel alloc]init];
    rightLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    rightLable.textColor = [UIColor colorWithWhite:0.15 alpha:1];
    rightLable.textAlignment = NSTextAlignmentCenter;
    rightLable.numberOfLines = 0;
    rightLable.preferredMaxLayoutWidth = KScreenWidth / 3.0;
    [rightLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    rightLable.text = @"有效期";
    [headerView addSubview:rightLable];
    [rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(margin  * 2);
        make.left.equalTo(centerLable.mas_right);
        make.right.equalTo(headerView);
        make.width.mas_equalTo(KScreenWidth / 3.0);
        make.height.mas_equalTo(20);
    }];
    
    
    UIView *segment = [[UIView alloc]init];
    segment.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    [headerView addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightLable.mas_bottom).offset(margin  );
        make.left.equalTo(headerView);
        make.right.equalTo(headerView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *leftBottomLable = [[UILabel alloc]init];
    leftBottomLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    leftBottomLable.textColor = [UIColor colorWithWhite:0.15 alpha:1];
    leftBottomLable.textAlignment = NSTextAlignmentCenter;
    leftBottomLable.numberOfLines = 0;
    leftBottomLable.preferredMaxLayoutWidth = KScreenWidth / 3.0;
    [leftBottomLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    leftBottomLable.text = @"会员";
    [headerView addSubview:leftBottomLable];
    [leftBottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLable.mas_bottom).offset(margin  * 4);
        make.left.equalTo(headerView);
        make.width.mas_equalTo(KScreenWidth / 3.0);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *centerbottomLable = [[UILabel alloc]init];
    centerbottomLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    centerbottomLable.textColor = [UIColor colorWithWhite:0.15 alpha:1];
    centerbottomLable.textAlignment = NSTextAlignmentCenter;
    centerbottomLable.numberOfLines = 0;
    centerbottomLable.preferredMaxLayoutWidth = KScreenWidth / 3.0;
    [centerbottomLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    centerbottomLable.text = @"无";
    [headerView addSubview:centerbottomLable];
    [centerbottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLable.mas_bottom).offset(margin  * 4);
        make.left.equalTo(leftLable.mas_right);
        make.width.mas_equalTo(KScreenWidth / 3.0);
        make.height.mas_equalTo(20);
    }];
    
    
    
    UILabel *rightBottomLable = [[UILabel alloc]init];
    rightBottomLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    rightBottomLable.textColor = [UIColor colorWithWhite:0.15 alpha:1];
    rightBottomLable.textAlignment = NSTextAlignmentCenter;
    rightBottomLable.numberOfLines = 0;
    rightBottomLable.preferredMaxLayoutWidth = KScreenWidth / 3.0;
    [rightBottomLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    rightBottomLable.text = @"2020-04-23";
    [headerView addSubview:rightBottomLable];
    [rightBottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLable.mas_bottom).offset(margin * 2);
        make.left.equalTo(centerbottomLable.mas_right);
        make.width.mas_equalTo(KScreenWidth / 3.0);
        make.height.mas_equalTo(20);
    }];
    
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightButton setTitle:@"开通" forState:(UIControlStateNormal)];
    [rightButton setTitleColor:[UIColor colorWithWhite:0.15 alpha:1] forState:(UIControlStateNormal)];
    [rightButton addTarget:self action:@selector(rightTopButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    rightButton.layer.masksToBounds = YES;
    rightButton.layer.cornerRadius = 15;
    rightButton.backgroundColor = RGB(230, 210, 160, 1);
    [headerView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(rightBottomLable.mas_centerX);
        make.top.equalTo(rightBottomLable.mas_bottom).offset(margin);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    UIView *viewseg = [[UIView alloc]init];
    viewseg.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    [headerView addSubview:viewseg];
    [viewseg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightButton.mas_bottom).offset(margin * 2);
        make.left.equalTo(headerView) ;
        make.right.equalTo(headerView) ;
        make.height.mas_equalTo(margin);
    }];
    [headerView layoutIfNeeded];
    headerView.frame = CGRectMake(0, 0, KScreenWidth, viewseg.bottom);
    [self.tableView setTableHeaderView:headerView];
    
}
-(void)rightTopButtonAction
{
    
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
