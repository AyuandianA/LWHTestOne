//
//  LWHComplexSubViewController.h
//  LWHTestOne
//
//  Created by mac on 2020/5/19.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHBaseTwoTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LWHComplexSubViewController : UIViewController
@property (nonatomic,strong) LWHBaseTwoTableView *tableView;
@property (nonatomic,assign) BOOL canScroll;
@end

NS_ASSUME_NONNULL_END
