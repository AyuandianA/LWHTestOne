//
//  LWHWalletHeaderViewModel.h
//  LWHTestOne
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWHWalletHeaderModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^WalletHeaderBlock)(void);
@interface LWHWalletHeaderViewModel : NSObject

@property (nonatomic,strong) LWHWalletHeaderModel *WalletHeaderModel;

@property (nonatomic,strong) NSAttributedString *totalMoneyAtt;
@property (nonatomic,assign) CGFloat totalMoneyHeight;


-(void)getModelUseingUrlstring:(NSString *)urlString params:(NSDictionary *)params Block:(WalletHeaderBlock )block;

@end

NS_ASSUME_NONNULL_END
