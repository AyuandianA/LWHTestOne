
//
//  LWHDangQianShangPinView.m
//  zhibo
//
//  Created by 李武华 on 2020/5/26.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHDangQianShangPinView.h"

@interface LWHDangQianShangPinView ()
@property (nonatomic,strong) YYLabel *topLable;
@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) YYLabel *titleLable;
@property (nonatomic,strong) YYLabel *kuCunLable;
@property (nonatomic,strong) YYLabel *priceLable;

@end
@implementation LWHDangQianShangPinView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatSubLabless];
    }
    return self;
}
-(void)creatSubLabless
{
    CGFloat margin = 5;
    CGFloat width = 70;
    self.layer.cornerRadius = margin;
    self.backgroundColor = RGB(30, 30, 30, 0.2);
    
    YYLabel *topLabel = [[YYLabel alloc]init];
    topLabel.font = [UIFont systemFontOfSize:TextFont - 5 weight:1];
    topLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor whiteColor];
    topLabel.numberOfLines = 0;
    topLabel.preferredMaxLayoutWidth = self.width;
    [topLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self addSubview:topLabel];
    self.topLable = topLabel;
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self ).offset(margin );
        make.left.equalTo(self).offset(margin);
        make.right.equalTo(self).offset(-margin);
    }];
    topLabel.text = @"当前商品";
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = margin;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(margin);
        make.left.equalTo(self).offset(margin);
        make.right.equalTo(self).offset(-margin);
        make.bottom.equalTo(self).offset(-margin);
    }];
    
    UIImageView *topImage = [[UIImageView alloc]init];
    [topImage setImage:[UIImage imageNamed:@"teacherListTwo"]];
    [backView addSubview:topImage];
    self.topImage = topImage;
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView);
        make.left.equalTo(backView);
        make.right.equalTo(backView);
        make.height.mas_equalTo(width);
        make.width.mas_equalTo(width);
    }];
    
    YYLabel *titleLable = [[YYLabel alloc]init];
    titleLable.font = [UIFont systemFontOfSize:TextFont - 10 weight:-0.2];
    titleLable.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.textColor = [UIColor blackColor];
    titleLable.numberOfLines = 1;
    titleLable.preferredMaxLayoutWidth = 70;
    [titleLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [backView addSubview:titleLable];
    self.titleLable  = titleLable;
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImage.mas_bottom).offset(2);
        make.left.equalTo(topImage.mas_left);
        make.right.equalTo(topImage.mas_right);
    }];
    titleLable.text = @"苹果又大又脆又甜";
    
    
    YYLabel *kuCunLable = [[YYLabel alloc]init];
    kuCunLable.font = [UIFont systemFontOfSize:TextFont - 11 weight:-0.2];
    kuCunLable.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    kuCunLable.textAlignment = NSTextAlignmentLeft;
    kuCunLable.textColor = RGB(90, 210, 90, 1);
    kuCunLable.numberOfLines = 1;
    kuCunLable.preferredMaxLayoutWidth = 70;
    [kuCunLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [backView addSubview:kuCunLable];
    self.kuCunLable  = kuCunLable;
    [kuCunLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset(margin);
        make.left.equalTo(topImage.mas_left);
        make.right.equalTo(topImage.mas_right);
    }];
    kuCunLable.text = @"已售117件";
    
    
    YYLabel *priceLable = [[YYLabel alloc]init];
    priceLable.font = [UIFont systemFontOfSize:TextFont - 11 weight:-0.2];
    priceLable.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    priceLable.textAlignment = NSTextAlignmentLeft;
    priceLable.textColor = [UIColor redColor];
    priceLable.numberOfLines = 1;
    priceLable.preferredMaxLayoutWidth = 70;
    [priceLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [backView addSubview:priceLable];
    self.priceLable  = priceLable;
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kuCunLable.mas_bottom).offset(margin);
        make.left.equalTo(topImage.mas_left);
        make.right.equalTo(topImage.mas_right);
        make.bottom.equalTo(backView).offset(-margin);
    }];
    priceLable.text = @"¥168.00";
    
}
@end
