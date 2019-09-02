//
//  LWHWalletHeaderModel.h
//  LWHTestOne
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface surplusInfoModel : NSObject
//剩余金额
@property (nonatomic,copy) NSString *account_balance;
//门店余额
@property (nonatomic,copy) NSString *store_account_balance;
//冻结余额
@property (nonatomic,copy) NSString *freeze_money;

@end

@interface LWHWalletHeaderModel : NSObject

@property(nonatomic,strong) surplusInfoModel *surplusInfoModel;
//今日分成
@property (nonatomic,copy) NSString *totay_deductionmoney;
//总分成
@property (nonatomic,copy) NSString *total_deductionmoney;
//总赠送余额
@property (nonatomic,copy) NSString *user_give_money;
//可提现金额
@property (nonatomic,copy) NSString *can_deposit_money;
//不可体现金额
@property (nonatomic,copy) NSString *disabled_deposit_money;
//赠送的优惠券个数
@property (nonatomic,copy) NSString *user_card_num;


@end

NS_ASSUME_NONNULL_END


