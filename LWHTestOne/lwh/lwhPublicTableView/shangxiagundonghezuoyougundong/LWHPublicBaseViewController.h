//
//  LWHPublicBaseViewController.h
//  zhibo
//
//  Created by 李武华 on 2020/5/24.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "BaseViewController.h"
#import "LWHPublicBaseTableView.h"
#import "SGPagingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWHPublicBaseViewController : BaseViewController

@property (nonatomic,strong) LWHPublicBaseTableView *tableView;
@property (nonatomic,strong) SGPageContentScrollView *sgscrollView;
@property (nonatomic,strong) SGPageTitleView * titleClassView;
@property (nonatomic,strong) NSMutableArray *contArray;
-(void)subTabviewcanScr:(BOOL)canScr;
@end

NS_ASSUME_NONNULL_END
