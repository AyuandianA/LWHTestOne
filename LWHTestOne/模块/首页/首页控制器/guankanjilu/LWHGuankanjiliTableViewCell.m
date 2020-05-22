//
//  LWHGuankanjiliTableViewCell.m
//  LWHTestOne
//
//  Created by mac on 2020/5/22.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHGuankanjiliTableViewCell.h"

@interface LWHGuankanjiliTableViewCell ()
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *titleBottomLable;
@property (nonatomic,strong) UILabel *priceLeftLable;
@property (nonatomic,strong) UILabel *priceLable;
@property (nonatomic,assign) CGFloat margin;
@end
@implementation LWHGuankanjiliTableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHGuankanjiliTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHGuankanjiliTableViewCell"];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHGuankanjiliTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LWHGuankanjiliTableViewCell"];
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
    self.margin = 10;
    //初始化控件
    CGFloat leftIamgeWidth = (KScreenWidth - self.margin * 3)/3.0 ;
    self.leftImageView = [[UIImageView alloc]init];
    self.leftImageView.image = [UIImage imageNamed:@"teacherListTwo"];
    [self.contentView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.margin);
        make.left.equalTo(self.contentView).offset(self.margin);
        make.bottom.equalTo(self.contentView).offset(-self.margin * 2);
        make.width.mas_equalTo(leftIamgeWidth);
        make.height.mas_equalTo(leftIamgeWidth * 0.6);
    }];
    
    
    self.titleLable = [[UILabel alloc]init];
    self.titleLable.text = @"第四课时 上脸凹陷技术全解，上脸凹陷技术全解";
    self.titleLable.font = [UIFont systemFontOfSize:TextFont weight:1];
    self.titleLable.textColor = [UIColor blackColor];
    self.titleLable.textAlignment = NSTextAlignmentLeft;
    self.titleLable.numberOfLines = 0;
    self.titleLable.preferredMaxLayoutWidth = leftIamgeWidth  * 2;
    [self.titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(self.margin);
        make.top.equalTo(self.leftImageView.mas_top);
        make.right.equalTo(self.contentView).offset(-self.margin);
        make.width.mas_equalTo(leftIamgeWidth  * 2);
        make.height.mas_lessThanOrEqualTo(self.titleLable.font.lineHeight * 2 + 5);
    }];
    
    self.titleBottomLable = [[UILabel alloc]init];
    self.titleBottomLable.text = @"05年12月 20:00 200人观看";
    self.titleBottomLable.font = [UIFont systemFontOfSize:TextFont - 3 weight:-0.3];
    self.titleBottomLable.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    self.titleBottomLable.textAlignment = NSTextAlignmentLeft;
    self.titleBottomLable.preferredMaxLayoutWidth = leftIamgeWidth  * 2;
    [self.titleBottomLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:self.titleBottomLable];
    [self.titleBottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(self.margin);
        make.top.equalTo(self.titleLable.mas_bottom).offset(self.margin);
        make.width.mas_equalTo(leftIamgeWidth * 2);
        make.height.mas_lessThanOrEqualTo(TextFont + 5);
    }];
    
    self.priceLeftLable = [[UILabel alloc]init];
    self.priceLeftLable.text = @"观看时间:昨天21:12";
    self.priceLeftLable.font = [UIFont systemFontOfSize:TextFont - 3 weight:-0.3];
    self.priceLeftLable.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    self.priceLeftLable.textAlignment = NSTextAlignmentLeft;
    self.priceLeftLable.preferredMaxLayoutWidth =  leftIamgeWidth  * 3;
    [self.priceLeftLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:self.priceLeftLable];
    [self.priceLeftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(self.margin);
        make.bottom.equalTo(self.leftImageView.mas_bottom);
        make.width.mas_lessThanOrEqualTo(leftIamgeWidth * 2 - 200);
        make.height.mas_lessThanOrEqualTo(TextFont + 5);
    }];
    
    self.priceLable = [[UILabel alloc]init];
    self.priceLable.text = @"¥10000";
    self.priceLable.font = [UIFont systemFontOfSize:TextFont - 3 weight:-0.3];
    self.priceLable.textColor = MainTopColor;
    self.priceLable.textAlignment = NSTextAlignmentRight;
    self.priceLable.preferredMaxLayoutWidth = 200;
    [self.priceLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:self.priceLable];
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(self.margin);
        make.bottom.equalTo(self.leftImageView.mas_bottom);
        make.width.mas_lessThanOrEqualTo(190);
        make.height.mas_lessThanOrEqualTo(TextFont + 5);
    }];
    UIView *segment = [[UIView alloc]init];
    segment.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    [self.contentView addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-self.margin);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(self.margin);
        make.height.mas_equalTo(self.margin);
    }];
}

-(void)changeDataWithModel:(NSDictionary *)dic
{
    
}

-(void)changeDataWithModel:(NSDictionary *)dic andSection:(NSIndexPath *)indexPath
{

    
}

@end
