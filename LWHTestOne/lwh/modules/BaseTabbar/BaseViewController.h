//
//  BaseViewController.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/7.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property(assign,nonatomic)BOOL isHiddenReturnButton;

@property(strong,nonatomic)UIColor *naviTitleColor;

- (void)backAction;

@end

NS_ASSUME_NONNULL_END
