//
//  LWHCourseContentTwoCell.m
//  LWHTestOne
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHCourseContentTwoCell.h"

@interface LWHCourseContentTwoCell ()
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) YYLabel *titleLable;
@property (nonatomic,strong) YYLabel *timeLable;
@property (nonatomic,strong) YYLabel *shiKanLable;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,assign) CGFloat margin;
@end
@implementation LWHCourseContentTwoCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHCourseContentTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHCourseContentTwoCell"];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHCourseContentTwoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LWHCourseContentTwoCell"];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.margin = 10;
        //初始化控件
        [self chuShiHua];
    }
    return self;
}

//初始化数据
-(void)chuShiHua
{
    CGFloat imageWidth = 40;
    UIImageView *leftImageView = [[UIImageView alloc]init];
    [leftImageView setImage:[UIImage imageNamed:@"teacherListTwo"]];
    [self.contentView addSubview:leftImageView];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.leftImageView = leftImageView;
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(self.margin);
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(90);
    }];
    
    YYLabel *titleLable = [[YYLabel alloc]init];
    titleLable.font = [UIFont systemFontOfSize:TextFont weight:-0.1];
    titleLable.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.textColor = [UIColor blueColor];
    titleLable.numberOfLines = 0;
    titleLable.preferredMaxLayoutWidth = KScreenWidth - self.margin * 3 - imageWidth;
    [titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(leftImageView.mas_centerY);
        make.left.equalTo(leftImageView.mas_right).offset(self.margin);
        make.height.mas_lessThanOrEqualTo(titleLable.font.lineHeight * 2 + 2);
    }];
    self.titleLable = titleLable;

    YYLabel *timeLable = [[YYLabel alloc]init];
    timeLable.font = [UIFont systemFontOfSize:TextFont - 2 weight:-0.2];
    timeLable.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    timeLable.textAlignment = NSTextAlignmentLeft;
    timeLable.textColor = [UIColor colorWithWhite:0.5 alpha:0.9];
    timeLable.numberOfLines = 0;
    timeLable.preferredMaxLayoutWidth = KScreenWidth - self.margin * 3 - imageWidth;
    [timeLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:timeLable];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftImageView.mas_centerY).offset(self.margin);
        make.left.equalTo(leftImageView.mas_right).offset(self.margin);
        make.height.mas_lessThanOrEqualTo(timeLable.font.lineHeight * 1 + 2);
    }];
    self.timeLable = timeLable;
    
    YYLabel *shiKanLable = [[YYLabel alloc]init];
    shiKanLable.font = [UIFont systemFontOfSize:TextFont - 2 weight:-0.2];
    shiKanLable.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    shiKanLable.textAlignment = NSTextAlignmentLeft;
    shiKanLable.textColor = [UIColor whiteColor];
    [self.contentView addSubview:shiKanLable];
    [shiKanLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLable.mas_centerY);
        make.left.equalTo(timeLable.mas_right).offset(self.margin);
        make.height.mas_equalTo(shiKanLable.font.lineHeight * 1 + 4);
    }];
    self.shiKanLable = shiKanLable;
    shiKanLable.layer.cornerRadius = 5;
    shiKanLable.backgroundColor = [UIColor yellowColor];
    
    UIImageView *rightImageView = [[UIImageView alloc]init];
    [rightImageView setImage:[UIImage imageNamed:@"teacherListTwo"]];
    [self.contentView addSubview:rightImageView];
    rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.rightImageView = rightImageView;
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shiKanLable.mas_centerY);
        make.right.equalTo(self.contentView).offset(-self.margin);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
}

-(void)changeDataWithModel:(id )model
{
    self.titleLable.text = @"胎宝拥有了记忆功能胎宝拥有了记忆功能胎宝拥有了记忆功能胎宝";
    self.timeLable.text = @"时长：00:49:46";
    self.shiKanLable.text = @" 试看 ";
}

@end
