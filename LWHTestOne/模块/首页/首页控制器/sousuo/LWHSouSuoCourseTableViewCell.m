//
//  LWHSouSuoCourseTableViewCell.m
//  zhibo
//
//  Created by 李武华 on 2020/5/22.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHSouSuoCourseTableViewCell.h"

@interface LWHSouSuoCourseTableViewCell ()
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *titleBottomLable;
@property (nonatomic,strong) UILabel *priceLable;
@property (nonatomic,assign) CGFloat margin;
@end
@implementation LWHSouSuoCourseTableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHSouSuoCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHSouSuoCourseTableViewCell"];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHSouSuoCourseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LWHSouSuoCourseTableViewCell"];
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
    CGFloat leftIamgeWidth = (KScreenWidth - self.margin * 2 - self.margin)/2.0 - 30;
    self.leftImageView = [[UIImageView alloc]init];
    self.leftImageView.image = [UIImage imageNamed:@"teacherListTwo"];
    [self.contentView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(self.margin);
        make.left.equalTo(self.contentView).offset(self.margin);
        make.bottom.equalTo(self.contentView).offset(-self.margin);
        make.width.mas_equalTo(leftIamgeWidth);
        make.height.mas_equalTo(leftIamgeWidth * 0.6);
    }];
    
    
    self.titleLable = [[UILabel alloc]init];
    self.titleLable.text = @"大智慧";
    self.titleLable.font = [UIFont systemFontOfSize:TextFont weight:1];
    self.titleLable.textColor = [UIColor blackColor];
    self.titleLable.textAlignment = NSTextAlignmentLeft;
    self.titleLable.numberOfLines = 0;
    self.titleLable.preferredMaxLayoutWidth = KScreenWidth - leftIamgeWidth - self.margin * 3;
    [self.titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(self.margin);
        make.top.equalTo(self.leftImageView.mas_top);
        make.right.equalTo(self.contentView).offset(-self.margin);
        make.width.mas_equalTo(KScreenWidth - leftIamgeWidth - self.margin * 3);
        make.height.mas_lessThanOrEqualTo(self.titleLable.font.lineHeight * 2 + 5);
    }];
    
    self.titleBottomLable = [[UILabel alloc]init];
    self.titleBottomLable.text = @"10课时 丨3万人看过";
    self.titleBottomLable.font = [UIFont systemFontOfSize:TextFont - 3 weight:-0.3];
    self.titleBottomLable.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    self.titleBottomLable.textAlignment = NSTextAlignmentLeft;
    self.titleBottomLable.preferredMaxLayoutWidth = KScreenWidth - leftIamgeWidth - self.margin * 3;
    [self.titleBottomLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:self.titleBottomLable];
    [self.titleBottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(self.margin);
        make.top.equalTo(self.titleLable.mas_bottom).offset(self.margin);
        make.width.mas_equalTo(KScreenWidth - leftIamgeWidth - self.margin * 3);
    }];
    
    self.priceLable = [[UILabel alloc]init];
    self.priceLable.text = @"¥2882";
    self.priceLable.font = [UIFont systemFontOfSize:TextFont - 2 weight:-0.3];
    self.priceLable.textColor = MainTopColor;
    self.priceLable.backgroundColor = RGB(250, 240, 230, 1);
    self.priceLable.textAlignment = NSTextAlignmentCenter;
    self.priceLable.preferredMaxLayoutWidth = KScreenWidth - leftIamgeWidth - self.margin * 3;
    [self.priceLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self.contentView addSubview:self.priceLable];
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(self.margin);
        make.bottom.equalTo(self.leftImageView.mas_bottom);
    }];
    [self.priceLable sizeToFit];
    CGFloat width = self.priceLable.width + 10;
    CGFloat height = self.priceLable.height + 4;
    self.priceLable.layer.cornerRadius = 8;
    self.priceLable.layer.masksToBounds = YES;
    [self.priceLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    
}

-(void)changeDataWithModel:(NSDictionary *)dic
{
    
}


@end
