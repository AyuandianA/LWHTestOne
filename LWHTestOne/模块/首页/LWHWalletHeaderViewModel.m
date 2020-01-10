//
//  LWHWalletHeaderViewModel.m
//  LWHTestOne
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import "LWHWalletHeaderViewModel.h"

@implementation LWHWalletHeaderViewModel


-(void)getModelUseingUrlstring:(NSString *)urlString params:(NSDictionary *)params Block:(WalletHeaderBlock )block
{
    [LJCNetWorking POST_URL:urlString params:params dataBlock:^(id data) {
        if (data) {
            [self setTheWalletHeaderModelWithDic:data[@"data"]];
            block();
        }
    }];
}
//初始化数据
-(void)setTheWalletHeaderModelWithDic:(NSDictionary *)dic
{
    self.WalletHeaderModel = [LWHWalletHeaderModel modelWithDictionary:dic];
    NSString *totalMoney = [NSString stringWithFormat:@"%@",@"20.21"];
    NSString *totalMoneyOne = [NSString stringWithFormat:@"%@",@"85352.21"];
    NSString *totalMoneyTwo = [NSString stringWithFormat:@"账户总余额 (元)\n%@\n冻结金额 ¥%@",totalMoneyOne,totalMoney];
    NSMutableAttributedString *totalMoneyAtt = [[NSMutableAttributedString alloc]initWithString:totalMoneyTwo];
    totalMoneyAtt.font = [UIFont systemFontOfSize:TextFont];
    totalMoneyAtt.color = [UIColor whiteColor];
    if (![totalMoney isEqualToString:totalMoneyOne]) {
        [totalMoneyAtt setFont:[UIFont boldSystemFontOfSize:TextFont + 10] range:[totalMoneyTwo rangeOfString:totalMoneyOne]];
    }
    totalMoneyAtt.lineSpacing = TextFont;
    totalMoneyAtt.alignment = NSTextAlignmentCenter;
    self.totalMoneyAtt = totalMoneyAtt;
    
    self.totalMoneyHeight = [self getLableHeight:totalMoneyAtt width:KScreenWidth];
    NSLog(@"%f",self.totalMoneyHeight);
}
//计算yylable行高
-(CGFloat)getLableHeight:(NSAttributedString *)message width:(CGFloat)width {
    
    CGSize introSize = CGSizeMake(width, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:message];
    CGFloat introHeight = layout.textBoundingSize.height;
    return introHeight;
}
@end
