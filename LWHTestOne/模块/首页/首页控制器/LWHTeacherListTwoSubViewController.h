//
//  LWHTeacherListTwoSubViewController.h
//  LWHTestOne
//
//  Created by mac on 2020/5/21.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHPublicTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LWHTeacherListTwoSubViewController : UIViewController

@property (nonatomic,strong) LWHPublicTableView *tableView;
@property (nonatomic,assign) BOOL canScroll;
@end

NS_ASSUME_NONNULL_END
