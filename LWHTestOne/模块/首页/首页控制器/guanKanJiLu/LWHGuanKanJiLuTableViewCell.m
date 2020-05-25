//
//  LWHGuanKanJiLuTableViewCell.m
//  LWHTestOne
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHGuanKanJiLuTableViewCell.h"


@interface LWHGuanKanJiLuTableViewCell ()
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *lookNumLable;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,strong) UILabel *jieShuLable;
@property (nonatomic,assign) CGFloat margin;
@end

@implementation LWHGuanKanJiLuTableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHGuanKanJiLuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHGuanKanJiLuTableViewCell"];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHGuanKanJiLuTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LWHGuanKanJiLuTableViewCell"];
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
    CGFloat iamgeWidth = (KScreenWidth - self.margin * 3) / 3.0;
    UIImageView *userImageView = [[UIImageView alloc]init];
    [userImageView setImage:[UIImage imageNamed:@"teacherListTwo"]];
    [self.contentView addSubview:userImageView];
    [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.margin );
        make.left.equalTo(self.contentView).offset(self.margin);
        make.bottom.equalTo(self.contentView).offset(-self.margin );
        make.width.mas_equalTo(iamgeWidth);
        make.height.mas_equalTo(iamgeWidth * 0.65);
    }];
    self.userImageView = userImageView;
    
    CGFloat preWidth = KScreenWidth - iamgeWidth - self.margin * 3;
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.font = [UIFont systemFontOfSize:TextFont ];
    titleLable.textColor = [UIColor blackColor];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.numberOfLines = 0;
    titleLable.preferredMaxLayoutWidth = preWidth;
    [titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImageView.mas_top);
        make.left.equalTo(self.userImageView.mas_right).offset(self.margin);
        make.height.mas_lessThanOrEqualTo(titleLable.font.lineHeight * 2 + 2);
    }];
    self.titleLable = titleLable;
    
    UILabel *lookNumLable = [[UILabel alloc]init];
    lookNumLable.font = [UIFont systemFontOfSize:TextFont - 2  weight:-0.3];
    lookNumLable.textAlignment = NSTextAlignmentLeft;
    lookNumLable.textColor = RGB(140, 140, 99, 1);
    lookNumLable.numberOfLines = 0;
    lookNumLable.preferredMaxLayoutWidth = preWidth;
    [lookNumLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:lookNumLable];
    [lookNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable.mas_bottom).offset(self.margin/2);
        make.left.equalTo(self.userImageView.mas_right).offset(self.margin);
        make.height.mas_lessThanOrEqualTo(lookNumLable.font.lineHeight + 2);
    }];
    self.lookNumLable = lookNumLable;
    
    
    UILabel *timeLable = [[UILabel alloc]init];
    timeLable.font = [UIFont systemFontOfSize:TextFont - 3  weight:-0.3];
    timeLable.textColor = RGB(140, 140, 99, 1);
    timeLable.textAlignment = NSTextAlignmentLeft;
    timeLable.numberOfLines = 0;
    timeLable.preferredMaxLayoutWidth = preWidth - self.margin  - 50;
    [timeLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:timeLable];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userImageView.mas_bottom);
        make.left.equalTo(self.userImageView.mas_right).offset(self.margin);
        make.height.mas_lessThanOrEqualTo(timeLable.font.lineHeight + 2);
    }];
    self.timeLable = timeLable;
    
    UILabel *jieShuLable = [[UILabel alloc]init];
    jieShuLable.font = [UIFont systemFontOfSize:TextFont - 3  weight:-0.3];
    jieShuLable.textAlignment = NSTextAlignmentRight;
    jieShuLable.textColor = [UIColor redColor];
    jieShuLable.numberOfLines = 0;
    jieShuLable.preferredMaxLayoutWidth =  50;
    [jieShuLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:jieShuLable];
    [jieShuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userImageView.mas_bottom);
        make.right.equalTo(self.contentView).offset(-self.margin);
        make.height.mas_lessThanOrEqualTo(timeLable.font.lineHeight + 2);
    }];
    self.jieShuLable = jieShuLable;
    
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
-(void)changeDataWithModel:(id )model
{

    self.titleLable.text = @"第四课时：上睑下垂上睑下垂上睑下垂上睑下垂上睑下垂上睑下垂上睑下垂上睑下垂上睑下垂上睑下垂";
    self.lookNumLable.text = @"2345人观看";
    self.timeLable.text = @"开始时间：09月09日 19：30";
    self.jieShuLable.text = @"已结束";
}
@end
