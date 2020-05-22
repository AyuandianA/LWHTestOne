//
//  LWHShengJiVIPViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/22.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHShengJiVIPViewController.h"

#import "BaseNaviController.h"
#import "LWHPublicTableView.h"
@interface LWHShengJiVIPViewController ()
@property (nonatomic,strong) LWHPublicTableView *tableView;
@property (nonatomic,strong) UILabel *priceLable;
@end

@implementation LWHShengJiVIPViewController
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
    self.title = @"升级VIP";
    [self.view addSubview:self.tableView];
}

#pragma mark 获取数据源
-(void)getDataSources
{
    for (int i = 0; i < 4; i++) {
        [self.tableView.PublicSourceArray addObject:@{@"time":@"2020-03-30 13：55：33",@"title":@"四库国学之奇门遁甲课程"}];
    }
    [self.tableView reloadData];
}

-(LWHPublicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [LWHPublicTableView creatPublicTableViewWithFrame:CGRectMake(0, TopHeight , KScreenWidth,KScreenHeight - TopHeight - BottomHeight) style:(UITableViewStyleGrouped)];
        _tableView.cellName = @"LWHShengJiVIPTableViewCell";
        //头视图
        UIView *headerView = [[UIView alloc]init];
        headerView.backgroundColor = [UIColor whiteColor];
        
        CGFloat margin = 10;
        UILabel *priceleftLable = [[UILabel alloc]init];
        priceleftLable.font = [UIFont systemFontOfSize:TextFont - 2 weight:-0.3];
        priceleftLable.text = @"充值金额 ¥";
        priceleftLable.textColor = [UIColor blackColor];
        [headerView addSubview:priceleftLable];
        priceleftLable.frame = CGRectMake(10, 20, 100, TextFont + 2);
        [priceleftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView).offset(margin * 2);
            make.left.equalTo(headerView).offset(margin);
        }];
        
        UILabel *price = [[UILabel alloc]init];
        price.font = [UIFont systemFontOfSize:TextFont + 3 weight:-0.2];
        price.text = @"365.0";
        price.textColor = [UIColor blackColor];
        [headerView addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(priceleftLable.mas_right).offset(margin);
            make.centerY.equalTo(priceleftLable.mas_centerY);
        }];
        self.priceLable = price;
        
        UILabel *priceBottom = [[UILabel alloc]init];
        priceBottom.font = [UIFont systemFontOfSize:TextFont - 4 weight:-0.2];
        priceBottom.textColor = [UIColor orangeColor];
        priceBottom.numberOfLines = 0;
        priceBottom.preferredMaxLayoutWidth = KScreenWidth - margin * 2;
        [priceBottom setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
        [headerView addSubview:priceBottom];
        priceBottom.text = @"温馨提示:VIP有效期365天，VIP有效期365天，VIP有效期365天，VIP有效期365天，VIP有效期365天";
        [priceBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(price.mas_bottom).offset(margin);
            make.left.equalTo(headerView).offset(margin);
            make.right.equalTo(headerView).offset(-margin);
        }];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithWhite:0.98 alpha:0.5];
        [headerView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceBottom.mas_bottom).offset(margin);
            make.left.equalTo(headerView);
            make.right.equalTo(headerView);
            make.height.mas_equalTo(40);
        }];
        
        UILabel *bottomLable = [[UILabel alloc]init];
        bottomLable.font = [UIFont systemFontOfSize:TextFont - 2 weight:-0.3];
        bottomLable.text = @"请选择支付方式";
        bottomLable.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [headerView addSubview:bottomLable];
        [bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bottomView.mas_centerY);
            make.left.equalTo(headerView).offset(margin);
            make.right.equalTo(headerView).offset(-margin);
        }];
        [headerView layoutIfNeeded];
        headerView.frame = CGRectMake(0, 0, KScreenWidth, bottomView.bottom);
        _tableView.tableHeaderView = headerView;
       //尾视图
        UIView *footerView = [[UIView alloc]init];
        footerView.backgroundColor = [UIColor whiteColor];
        
        UIButton *commitButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [commitButton setTitle:@"立即充值" forState:(UIControlStateNormal)];
        [commitButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [commitButton addTarget:self action:@selector(commitButtonButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        commitButton.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        commitButton.backgroundColor = [UIColor blueColor];
//        commitButton.layer.masksToBounds = YES;
        commitButton.layer.cornerRadius = 20;
        [footerView addSubview:commitButton];
        [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView).offset(margin * 4);
            make.left.equalTo(footerView).offset(margin * 3);
            make.right.equalTo(footerView).offset(-margin * 3);
            make.height.mas_equalTo(40);
        }];
        
        UIButton *commitBottomButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [commitBottomButton setTitle:@"0元升级" forState:(UIControlStateNormal)];
        [commitBottomButton setTitleColor:MainTopColor forState:(UIControlStateNormal)];
        [commitBottomButton addTarget:self action:@selector(commitBottomButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        commitBottomButton.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        commitBottomButton.layer.borderWidth = 1;
        commitBottomButton.layer.borderColor = MainTopColor.CGColor;
//        commitBottomButton.layer.masksToBounds = YES;
        commitBottomButton.layer.cornerRadius = 20;
        [footerView addSubview:commitBottomButton];
        [commitBottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(commitButton.mas_bottom).offset(margin * 2);
            make.left.equalTo(footerView).offset(margin * 3);
            make.right.equalTo(footerView).offset(-margin * 3);
            make.height.mas_equalTo(40);
        }];
        
        [footerView layoutIfNeeded];
        footerView.frame = CGRectMake(0, 0, KScreenWidth, commitBottomButton.bottom + margin * 4);
        _tableView.tableFooterView = footerView;
        
        
    }
    return _tableView;
}
-(void)commitButtonButtonAction
{
    
}
-(void)commitBottomButtonAction
{
    
}
@end
