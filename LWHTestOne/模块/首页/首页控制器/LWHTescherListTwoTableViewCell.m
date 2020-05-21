//
//  LWHTescherListTwoTableViewCell.m
//  LWHTestOne
//
//  Created by mac on 2020/5/21.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHTescherListTwoTableViewCell.h"

@interface LWHTescherListTwoTableViewCell ()
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *learnNumLable;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,assign) CGFloat margin;
@end

@implementation LWHTescherListTwoTableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHTescherListTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHTescherListTwoTableViewCell"];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHTescherListTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LWHTescherListTwoTableViewCell"];
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
    CGFloat iamgeWidth = (KScreenWidth - self.margin * 3) / 2.0 - 10;
    self.userImageView = [[UIImageView alloc]init];
    [self.userImageView setImage:[UIImage imageNamed:@"teacherList"]];
    self.userImageView.layer.cornerRadius = 7;
    self.userImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.margin * 2);
        make.left.equalTo(self.contentView).offset(self.margin);
        make.bottom.equalTo(self.contentView).offset(-self.margin);
        make.width.mas_equalTo(iamgeWidth);
        make.height.mas_equalTo(iamgeWidth * 0.5);
    }];
    
    UILabel *learnNumLable = [[UILabel alloc]init];
    learnNumLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    learnNumLable.textColor = [UIColor colorWithWhite:0 alpha:1];
    learnNumLable.numberOfLines = 0;
    learnNumLable.preferredMaxLayoutWidth = iamgeWidth;
    [learnNumLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:learnNumLable];
    [learnNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userImageView.mas_bottom).offset(-self.margin);
        make.right.equalTo(self.userImageView.mas_right).offset(-self.margin);
        make.width.mas_lessThanOrEqualTo(iamgeWidth);
    }];
    
    CGFloat preWidth = KScreenWidth - iamgeWidth - self.margin * 3;
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.font = [UIFont systemFontOfSize:TextFont weight:-0.3];
    titleLable.textColor = [UIColor colorWithWhite:0 alpha:1];
    titleLable.numberOfLines = 0;
    titleLable.preferredMaxLayoutWidth = preWidth;
    [titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_top);
        make.left.equalTo(self.userImageView.mas_right).offset(self.margin);
        make.width.mas_lessThanOrEqualTo(preWidth);
        make.height.mas_lessThanOrEqualTo(titleLable.font.lineHeight * 2 + 2);
    }];
    self.titleLable = titleLable;
    
    UILabel *timeLable = [[UILabel alloc]init];
    timeLable.font = [UIFont systemFontOfSize:TextFont - 2 weight:-0.3];
    timeLable.textColor = [UIColor colorWithWhite:0.65 alpha:1];
    timeLable.numberOfLines = 0;
    timeLable.preferredMaxLayoutWidth = preWidth;
    [timeLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:timeLable];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userImageView.mas_bottom);
        make.left.equalTo(self.userImageView.mas_right).offset(self.margin);
        make.width.mas_lessThanOrEqualTo(preWidth);
    }];
    self.timeLable = timeLable;
    
}
-(void)changeDataWithModel:(LWHTeacherListTwoModel *)model
{
    self.userImageView.image = [UIImage imageNamed:@"teacherListTwo"];
    self.learnNumLable.text = @"36人已学习";
    self.titleLable.text = @"鬼谷子";
    self.timeLable.text = @"¥2887 丨 2节";
}
@end
