//
//  LWHShuRuYaoQingViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/26.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHShuRuYaoQingViewController.h"

@interface LWHShuRuYaoQingViewController ()

@end

@implementation LWHShuRuYaoQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat margin = 10;
    UIView *topBackView = [[UIView alloc]init];
    topBackView.backgroundColor = RGB(250, 250, 250, 1);
    [self.view addSubview:topBackView];
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(TopHeight);
    }];
    
    YYLabel *yaoQingTop = [[YYLabel alloc]init];
    yaoQingTop.font = [UIFont systemFontOfSize:TextFont + 3 weight:1];
    yaoQingTop.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    yaoQingTop.textAlignment = NSTextAlignmentCenter;
    yaoQingTop.textColor = [UIColor blackColor];
    [topBackView addSubview:yaoQingTop];
    [yaoQingTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBackView).offset(margin * 2);
        make.left.right.equalTo(topBackView);
    }];
    yaoQingTop.text = @"请输入邀请码：";
    
    
    YYLabel *yaoQingBottom = [[YYLabel alloc]init];
    yaoQingBottom.font = [UIFont systemFontOfSize:TextFont - 2 weight:-0.3];
    yaoQingBottom.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    yaoQingBottom.textAlignment = NSTextAlignmentCenter;
    yaoQingBottom.textColor = [UIColor blackColor];
    [topBackView addSubview:yaoQingBottom];
    yaoQingBottom.numberOfLines = 0;
    yaoQingBottom.preferredMaxLayoutWidth = KScreenWidth  - margin * 2;
    [yaoQingBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yaoQingTop.mas_bottom).offset(margin * 2);
        make.left.right.equalTo(topBackView).offset(margin);
        make.bottom.equalTo(topBackView).offset(-margin * 2);
    }];
    yaoQingBottom.text = @"红富士苹果直播卖货，速来围观 红富士苹果直播卖货";
    
    
    
}



@end
