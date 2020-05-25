//
//  LWHCourseContentViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHCourseContentViewController.h"
#import "SGPagingView.h"
#import "LWHPublicBaseTwoViewController.h"
@interface LWHCourseContentViewController ()

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *userNameLable;
@property (nonatomic,strong) UILabel *courseNum;
@property (nonatomic,strong) UILabel *learnNum;
@property (nonatomic,strong) UIButton *havend;

@end

@implementation LWHCourseContentViewController
#pragma mark 视图已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, TopHeight, KScreenWidth, KScreenHeight - TopHeight );
    [self.tableView reloadData];
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

    self.titleClassView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 50) delegate:nil titleNames:@[@"课程目录",@"讲师介绍"] configure:configure1];
    self.titleClassView.selectedIndex = 0;

    LWHPublicBaseTwoViewController *subCtr = [[LWHPublicBaseTwoViewController  alloc]init];

    __weak typeof(subCtr)weakSubCtr = subCtr;
    subCtr.tableView.frame = self.tableView.bounds;
    subCtr.tableView.cellName = @"LWHCourseContentHtmlCell";
    subCtr.tableView.cellSections = ^NSInteger{
        return weakSubCtr.tableView.PublicSourceArray.count;
    };
    subCtr.tableView.cellRows = ^NSInteger(NSInteger section) {
      return [weakSubCtr.tableView.PublicSourceArray[section] count];
    };
    [subCtr.tableView.PublicSourceArray addObject:@[@"3135324"]];
    [subCtr.tableView.PublicSourceArray addObject:@[@"2345235234523523452352345235234523523452352345235234523523452352345235234523523452352345235234523523452352345235234523523452352345235"]];
    [subCtr.tableView.PublicSourceArray addObject:@[@"3452345"]];
    [subCtr.tableView reloadData];
    
    LWHPublicBaseTwoViewController *subCtr2 = [[LWHPublicBaseTwoViewController  alloc]init];
    subCtr2.tableView.frame = self.tableView.bounds;
    subCtr2.tableView.cellName = @"LWHCourseContentTwoCell";
    for (NSString *string in @[@"3135324",@"3135324",@"3135324",@"3135324"]) {
        [subCtr2.tableView.PublicSourceArray addObject:string];
    }
    [subCtr2.tableView reloadData];
    [self.contArray addObject: subCtr];
    [self.contArray addObject: subCtr2];
    
    self.sgscrollView = [[SGPageContentScrollView  alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth  , self.tableView.height - 50) parentVC:self childVCs:self.contArray];
    self.sgscrollView.isAnimated = YES;
    [self.sgscrollView setPageContentScrollViewCurrentIndex:0];
}
-(void)havendButtonAction
{

}
@end
