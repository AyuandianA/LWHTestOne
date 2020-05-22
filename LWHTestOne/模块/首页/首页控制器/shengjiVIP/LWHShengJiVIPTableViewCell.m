//
//  LWHShengJiVIPTableViewCell.m
//  LWHTestOne
//
//  Created by mac on 2020/5/22.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHShengJiVIPTableViewCell.h"


@interface LWHShengJiVIPTableViewCell ()
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,assign) CGFloat margin;
@end

@implementation LWHShengJiVIPTableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHShengJiVIPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHShengJiVIPTableViewCell"];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHShengJiVIPTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LWHShengJiVIPTableViewCell"];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //初始化控件
        [self chuShiHua];
    }
    return self;
}


//初始化数据
-(void)chuShiHua
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.margin = 10;
    //初始化子控件
    CGFloat iamgeWidth = 30;
    self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, 60, 60)];
    [self.userImageView setImage:[UIImage imageNamed:@"teacherList"]];
    self.userImageView.layer.cornerRadius = 7;
    self.userImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.margin);
        make.left.equalTo(self.contentView).offset(self.margin);
        make.bottom.equalTo(self.contentView).offset(-self.margin);
        make.width.mas_equalTo(iamgeWidth);
        make.height.mas_equalTo(iamgeWidth);
    }];
    CGFloat preWidth = KScreenWidth - iamgeWidth - self.margin * 3;
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    titleLable.textColor = [UIColor colorWithWhite:0 alpha:1];
    titleLable.numberOfLines = 0;
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.preferredMaxLayoutWidth = preWidth;
    [titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_top);
        make.left.equalTo(self.userImageView.mas_right).offset(self.margin);
        make.width.mas_lessThanOrEqualTo(preWidth);
        make.height.mas_lessThanOrEqualTo(titleLable.font.lineHeight + 2);
    }];
    self.titleLable = titleLable;
    
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@""] forState:(UIControlStateSelected)];
    [button addTarget:self action:@selector(buttonButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    [self.contentView addSubview:button];
    self.button = button;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImageView.mas_centerY);
        make.right.equalTo(self.contentView).offset(-self.margin);
        make.height.width.mas_equalTo(20);
    }];
    UIView *segmentView = [[UIView alloc]init];
    segmentView.backgroundColor = RGB(250, 250, 250, 1);
    [self.contentView addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.8);
    }];
    
}
-(void)buttonButtonAction
{
    
}
-(void)changeDataWithModel:(NSDictionary *)dic
{
    self.titleLable.text = dic[@"title"];
}

-(void)changeDataWithModel:(NSDictionary *)dic andSection:(NSInteger)section
{
    
}
@end
