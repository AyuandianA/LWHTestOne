//
//  LWHWalletHeaderView.h
//  LWHTestOne
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHWalletHeaderViewModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface LWHWalletHeaderView : UIView

@property (nonatomic,strong) LWHWalletHeaderViewModel *WalletHeaderViewModel;

+(instancetype)standardWalletHeaderViewWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
