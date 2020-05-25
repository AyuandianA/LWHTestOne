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
    userName.textAlignment = NSTextAlignmentCenter;
    userName.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    userName.text  = @"王主任";
    [self addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userImageView.mas_bottom).offset(margin * 3);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    YYLabel *daoJiShi = [[YYLabel alloc]init];
    daoJiShi.font = [UIFont systemFontOfSize:TextFont weight:-0.2];
    daoJiShi.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    daoJiShi.textColor = [UIColor whiteColor];
    daoJiShi.numberOfLines = 0;
    daoJiShi.preferredMaxLayoutWidth = KScreenWidth;
    [daoJiShi setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self addSubview:daoJiShi];
    [daoJiShi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userName.mas_bottom).offset(margin * 4);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(TextFont + 10);
    }];
    daoJiShi.attributedText = [self creatDaoJiShiString];
    
    YYLabel *daoJiShiBottom = [[YYLabel alloc]init];
    daoJiShiBottom.font = [UIFont systemFontOfSize:TextFont weight:-0.1];
    daoJiShiBottom.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    daoJiShiBottom.textColor = [UIColor blackColor];
    daoJiShiBottom.numberOfLines = 0;
    daoJiShiBottom.preferredMaxLayoutWidth = KScreenWidth;
    [daoJiShiBottom setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisVertical)];
    [self addSubview:daoJiShiBottom];
    [daoJiShiBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(daoJiShi.mas_bottom).offset(margin * 2);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(TextFont + 10);
    }];
    daoJiShiBottom.attributedText = [self creatYiGeNumString:@"2020年6月4号  12：00：00开播" corner:25 insets:30];
    
    YYLabel *bottomLable = [[YYLabel alloc]init];
    bottomLable.font = [UIFont systemFontOfSize:TextFont + 10 weight:1.5];
    bottomLable.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    bottomLable.textAlignment = NSTextAlignmentCenter;
    bottomLable.textColor = [UIColor whiteColor];
    [self addSubview:bottomLable];
    [bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(daoJiShiBottom.mas_bottom).offset(margin * 5);
        make.left.right.equalTo(self);
    }];
    bottomLable.text = @"直播未开始";
    
}
-(void)takeDataWithDic:(NSDictionary *)dic
{
    
}
-(void)cancelButtonAction
{
    [self removeFromSuperview];
}
-(NSMutableAttributedString *)creatDaoJiShiString
{
    NSMutableAttributedString *daoJiShiAtt = [self creatYiGeTextString:@"直播倒计时 "];
    
    [daoJiShiAtt appendAttributedString:[self creatYiGeNumString:@" 00 " corner:5 insets:1]];
    [daoJiShiAtt appendAttributedString:[self creatYiGeTextString:@" 天 "]];
    [daoJiShiAtt appendAttributedString:[self creatYiGeNumString:@" 03 " corner:5 insets:1]];
    [daoJiShiAtt appendAttributedString:[self creatYiGeTextString:@" 时 "]];
    [daoJiShiAtt appendAttributedString:[self creatYiGeNumString:@" 03 " corner:5 insets:1]];
    [daoJiShiAtt appendAttributedString:[self creatYiGeTextString:@" 分 "]];
    [daoJiShiAtt appendAttributedString:[self creatYiGeNumString:@" 03 " corner:5 insets:1]];
    [daoJiShiAtt appendAttributedString:[self creatYiGeTextString:@" 秒 "]];
    return daoJiShiAtt;
}
-(NSMutableAttributedString *)creatYiGeTextString:(NSString *)string
{
    NSMutableAttributedString *tianAtt = [[NSMutableAttributedString alloc]initWithString:string];
    tianAtt.font = [UIFont systemFontOfSize:TextFont];
    tianAtt.color = [UIColor whiteColor];
    tianAtt.alignment = NSTextAlignmentCenter;
    return tianAtt;
}

-(NSMutableAttributedString *)creatYiGeNumString:(NSString *)string corner:(CGFloat)corner insets:(CGFloat)insets
{
    NSMutableAttributedString *attOne = [[NSMutableAttributedString alloc]initWithString:string];
    attOne.font = [UIFont systemFontOfSize:TextFont];
    attOne.color = [UIColor blackColor];
    attOne.alignment = NSTextAlignmentCenter;
    YYTextBorder *border = [YYTextBorder new];
    border.cornerRadius = corner;
    border.fillColor = [UIColor whiteColor];
    border.insets=UIEdgeInsetsMake(-3,-insets,-3,-insets);
    border.lineStyle = YYTextLineStyleSingle;
    attOne.textBackgroundBorder = border;
    return attOne;
}
@end
