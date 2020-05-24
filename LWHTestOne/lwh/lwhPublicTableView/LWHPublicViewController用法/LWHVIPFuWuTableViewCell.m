//
//  LWHVIPFuWuTableViewCell.m
//  zhibo
//
//  Created by 李武华 on 2020/5/22.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHVIPFuWuTableViewCell.h"

@interface LWHVIPFuWuTableViewCell ()
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *priceLable;
@property (nonatomic,strong) UILabel *huiYuanLable;
@property (nonatomic,strong) UILabel *youXiaoQiLable;
@property (nonatomic,strong) UIButton *xuFeiButton;
@property (nonatomic,assign) CGFloat margin;
@end

@implementation LWHVIPFuWuTableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHVIPFuWuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHVIPFuWuTableViewCell"];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHVIPFuWuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LWHVIPFuWuTableViewCell"];
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
    CGFloat iamgeWidth = 60;
    UIImageView *userImageView = [[UIImageView alloc]init];
    [userImageView setImage:[UIImage imageNamed:@"teacherList"]];
    [self.contentView addSubview:userImageView];
    [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.margin * 2);
        make.left.equalTo(self.contentView).offset(self.margin);
        make.bottom.equalTo(self.contentView).offset(-self.margin * 2);
        make.width.mas_equalTo(iamgeWidth);
        make.height.mas_equalTo(iamgeWidth);
    }];
    self.userImageView = userImageView;
    
    CGFloat preWidth = KScreenWidth - iamgeWidth - self.margin * 3;
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.font = [UIFont systemFontOfSize:TextFont + 6 ];
    titleLable.textColor = MainTopColor;
    titleLable.numberOfLines = 0;
    titleLable.text = @"¥ 3987";
    titleLable.preferredMaxLayoutWidth = preWidth;
    [titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_top).offset(-self.margin);
        make.left.equalTo(self.userImageView.mas_right).offset(self.margin);
        make.right.equalTo(self.contentView).offset(-self.margin);
        make.width.mas_equalTo(preWidth);
        make.height.mas_lessThanOrEqualTo(titleLable.font.lineHeight  + 2);
    }];
    self.priceLable = titleLable;
    
    UILabel *timeLable = [[UILabel alloc]init];
    timeLable.font = [UIFont systemFontOfSize:TextFont - 2  weight:-0.3];
    timeLable.textColor = RGB(140, 140, 99, 1);
    timeLable.text = @"会员";
    timeLable.numberOfLines = 0;
    timeLable.preferredMaxLayoutWidth = preWidth;
    [timeLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:timeLable];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLable.mas_bottom).offset(self.margin/2);
        make.left.equalTo(self.userImageView.mas_right).offset(self.margin);
        make.width.mas_lessThanOrEqualTo(preWidth - 70 - self.margin);
    }];
    self.huiYuanLable = timeLable;
    
    
    UILabel *timeBottomLable = [[UILabel alloc]init];
    timeBottomLable.font = [UIFont systemFontOfSize:TextFont - 2  weight:-0.3];
    timeBottomLable.textColor = RGB(140, 140, 99, 1);
    timeBottomLable.text = @"有效期限：365天";
    timeBottomLable.numberOfLines = 0;
    timeBottomLable.preferredMaxLayoutWidth = preWidth;
    [timeBottomLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:timeBottomLable];
    [timeBottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.huiYuanLable.mas_bottom).offset(self.margin/2);
        make.left.equalTo(self.userImageView.mas_right).offset(self.margin);
        
        make.width.mas_lessThanOrEqualTo(preWidth - 70 - self.margin);
    }];
    self.youXiaoQiLable = timeBottomLable;
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightButton setTitle:@"开通" forState:(UIControlStateNormal)];
    [rightButton setTitleColor:[UIColor colorWithWhite:0.15 alpha:1] forState:(UIControlStateNormal)];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    rightButton.layer.masksToBounds = YES;
    rightButton.layer.cornerRadius = 15;
    rightButton.backgroundColor = RGB(230, 210, 160, 1);
    [self.contentView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImageView.mas_centerY);
        make.right.equalTo(self.contentView).offset(-self.margin);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(30);
    }];
    
    
    UIView *segment = [[UIView alloc]init];
    segment.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    [self.contentView addSubview: segment];
    [segment  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
}
-(void)rightButtonAction
{
    
}
-(void)changeDataWithModel:(id _Nullable *_Nullable)model
{
    
}

-(void)changeDataWithModel:(id _Nullable *_Nullable)model andSection:(NSInteger)section
{
    
}
@end
