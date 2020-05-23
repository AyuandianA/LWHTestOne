//
//  LWHZhiBoWeiKaiShiView.m
//  LWHTestOne
//
//  Created by mac on 2020/5/23.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHZhiBoWeiKaiShiView.h"

@implementation LWHZhiBoWeiKaiShiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.6];
        [self ceratSubViews];
    }
    return self;
}
-(void)ceratSubViews
{
    CGFloat margin = 10;
    
    UIButton *cancel = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cancel setImage:[UIImage imageNamed:@"left_return_white"] forState:(UIControlStateNormal)];
    [cancel addTarget:self action:@selector(cancelButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin * 2 + StatusHeight);
        make.left.equalTo(self).offset(margin * 2);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *share = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [share setImage:[UIImage imageNamed:@"left_return_white"] forState:(UIControlStateNormal)];
    [share addTarget:self action:@selector(cancelButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:share];
    [share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(margin * 2+ StatusHeight);
        make.right.equalTo(self).offset(-margin * 2);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    
    UIImageView *userImageView = [[UIImageView alloc]init];
    [userImageView setImage:[UIImage imageNamed:@"left_return_white"]];
    [self addSubview:userImageView];
    userImageView.layer.cornerRadius = 40;
    userImageView.layer.masksToBounds = YES;
    [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(share.mas_bottom).offset(margin * 3);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(80);
    }];
    
    YYLabel *userName = [[YYLabel alloc]init];
    userName.font = [UIFont systemFontOfSize:TextFont weight:-0.2];
    userName.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    userName.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    userName.text  = @"王主任";
    [self addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userImageView.mas_bottom).offset(margin * 3);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    
    NSMutableAttributedString *totalMoneyAtt = [[NSMutableAttributedString alloc]initWithString:@"直播倒计时 "];
    totalMoneyAtt.font = [UIFont systemFontOfSize:TextFont];
    totalMoneyAtt.color = [UIColor whiteColor];
    NSString *stringNem = [NSString stringWithFormat:@"00"];
    NSMutableAttributedString *attOne = [[NSMutableAttributedString alloc]initWithString:stringNem];
    attOne.font = [UIFont systemFontOfSize:TextFont];
    attOne.color = [UIColor blackColor];
    YYTextBorder *border = [YYTextBorder new];
    border.cornerRadius = 5;
    border.fillColor = [UIColor whiteColor];
    border.insets=UIEdgeInsetsMake(-1,-3,-1,-3);
    border.lineStyle = YYTextLineStyleSingle;
    attOne.textBackgroundBorder = border;
    [totalMoneyAtt appendAttributedString:attOne];
    totalMoneyAtt.alignment = NSTextAlignmentCenter;
    userName.attributedText = totalMoneyAtt;
    
    
}
-(void)takeDataWithDic:(NSDictionary *)dic
{
    
}
-(void)cancelButtonAction
{
    [self removeFromSuperview];
}
@end
