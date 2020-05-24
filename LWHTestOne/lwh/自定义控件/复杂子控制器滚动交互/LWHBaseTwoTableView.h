//
//  LWHBaseTwoTableView.h
//  LWHTestOne
//
//  Created by 李武华 on 2020/5/23.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHBaseTwoTableView : UITableView<UIGestureRecognizerDelegate>

@property (nonatomic,assign) BOOL canScroll;
@end

NS_ASSUME_NONNULL_END
