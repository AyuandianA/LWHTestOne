//
//  IssueDiaryViewController.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/20.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "BaseViewController.h"

@class OrderListModel;

NS_ASSUME_NONNULL_BEGIN

@interface IssueDiaryViewController : BaseViewController

@property(nonatomic, strong)OrderListModel *model;

@property(nonatomic, assign)int type;


@end

NS_ASSUME_NONNULL_END
