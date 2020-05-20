//
//  LWHPublicTableViewCell.m
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHPublicTableViewCell.h"

@interface LWHPublicTableViewCell ()
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,assign) CGFloat margin;
@end

@implementation LWHPublicTableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHPublicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHPublicTableViewCell"];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHPublicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LWHPublicTableViewCell"];
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
    CGFloat iamgeWidth = 100;
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
        make.height.mas_equalTo(60);
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
-(void)changeDataWithModel:(NSDictionary *)dic
{
}
@end
