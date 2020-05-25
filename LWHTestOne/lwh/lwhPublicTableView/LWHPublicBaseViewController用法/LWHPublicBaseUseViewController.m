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
@interface LWHPublicBaseUseViewController ()

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *userNameLable;
@property (nonatomic,strong) UILabel *courseNum;
@property (nonatomic,strong) UILabel *learnNum;
@property (nonatomic,strong) UIButton *havend;

@end

@implementation LWHPublicBaseUseViewController
#pragma mark 视图已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatHeaderView];
    [self creatTitleClassViewAndSgscrollView];
}
-(void)creatHeaderView
{
    UIImageView *userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40, 60, 60)];
    [userImageView setImage:[UIImage imageNamed:@"teacherList"]];
    userImageView.layer.masksToBounds = YES;
    userImageView.layer.cornerRadius = 30;
    self.userImageView = userImageView;

    UILabel *userNameLable = [[UILabel alloc]init];
    userNameLable.font = [UIFont systemFontOfSize:TextFont weight:-0.2];
    userNameLable.textColor = [UIColor whiteColor];
    userNameLable.numberOfLines = 0;
    userNameLable.preferredMaxLayoutWidth = KScreenWidth - 110;
    [userNameLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    self.userNameLable = userNameLable;

    UILabel *courseNum = [[UILabel alloc]init];
    courseNum.font = [UIFont systemFontOfSize:TextFont weight:-0.25];
    courseNum.textColor = [UIColor whiteColor];
    courseNum.numberOfLines = 0;
    courseNum.preferredMaxLayoutWidth = 90;
    [courseNum setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    self.courseNum = courseNum;

    UILabel *learnNum = [[UILabel alloc]init];
    learnNum.font = [UIFont systemFontOfSize:TextFont weight:-0.25];
    learnNum.textColor = [UIColor whiteColor];
    learnNum.numberOfLines = 0;
    learnNum.preferredMaxLayoutWidth = 90;
    [learnNum setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    self.learnNum = learnNum;

    UIButton *havend = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [havend setTitle:@"收藏" forState:(UIControlStateNormal)];
    [havend setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [havend setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    [havend addTarget:self action:@selector(havendButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    havend.titleLabel.font = [UIFont systemFontOfSize:TextFont];
    havend.backgroundColor = RGB(255, 255, 255, 0.1);
//    havend.layer.masksToBounds = YES;
    havend.layer.cornerRadius = 5;
    havend.layer.borderWidth = 0.5;
    havend.layer.borderColor = [UIColor colorWithWhite:0.98 alpha:0.5].CGColor;
    self.havend = havend;

    userNameLable.text = @"孔令伟老师";
    courseNum.text = @"40课程数量";
    learnNum.text = @"214学习人数";
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
    headerView.backgroundColor = [UIColor orangeColor];

    [headerView addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(15);
        make.top.equalTo(headerView).offset(40);
        make.width.height.mas_equalTo(60);
    }];
    [headerView addSubview:self.userNameLable];
    [self.userNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(20);
        make.top.equalTo(self.userImageView.mas_top);
    }];
    [headerView addSubview:self.courseNum];
    [self.courseNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(20);
        make.top.equalTo(self.userNameLable.mas_bottom).offset(20);
    }];
    [headerView addSubview:self.learnNum];
    [self.learnNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.courseNum.mas_right).offset(40);
        make.top.equalTo(self.userNameLable.mas_bottom).offset(20);
    }];
    [headerView addSubview:self.havend];
    [self.havend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.learnNum.mas_right).offset(40);
        make.centerY.equalTo(self.courseNum.mas_centerY);
        make.width.mas_equalTo(70);
    }];
    [headerView layoutIfNeeded];
    headerView.height = self.havend.bottom + 100;
    self.tableView.tableHeaderView =  headerView;
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

    for (int i = 0; i < 2; i++) {
        LWHPublicBaseTwoViewController *subCtr = [[LWHPublicBaseTwoViewController  alloc]init];

        subCtr.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - TopHeight  - BottomHeight);
        subCtr.tableView.cellName = @"LWHPublicTableViewCell";
        [subCtr.tableView.PublicSourceArray addObject:@[@{},@{},@{}]];
        [subCtr.tableView.PublicSourceArray addObject:@[@{},@{},@{}]];
        [subCtr.tableView.PublicSourceArray addObject:@[@{},@{},@{}]];
        [subCtr.tableView reloadData];
        [self.contArray addObject: subCtr];
    }
    self.sgscrollView = [[SGPageContentScrollView  alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth  , self.tableView.height - 50) parentVC:self childVCs:self.contArray];
    self.sgscrollView.isAnimated = YES;
    [self.sgscrollView setPageContentScrollViewCurrentIndex:0];
}
-(void)havendButtonAction
{

}
@end
