//
//  LWHTabbarBottomIView.h
//  ChengXianApp
//
//  Created by mac on 2020/4/26.
//  Copyright © 2020 WuHua . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHTabbarBottomIView : UIView


@property (nonatomic,strong) UIButton *tapButton;

-(instancetype)initWithFrame:(CGRect)rect andimage:(UIImage *)image obveHeight:(NSInteger)height;

@end

NS_ASSUME_NONNULL_END
