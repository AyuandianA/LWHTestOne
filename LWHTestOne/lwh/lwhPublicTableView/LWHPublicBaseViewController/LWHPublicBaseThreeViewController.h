//
//  LWHPublicBaseThreeViewController.h
//  zhibo
//
//  Created by 李武华 on 2020/5/26.
//  Copyright © 2020 李武华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHPublicCollectionView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LWHPublicBaseThreeViewController : UIViewController

@property (nonatomic,strong) LWHPublicCollectionView *tableView;
@property (nonatomic,assign) BOOL canScroll;

@end

NS_ASSUME_NONNULL_END
