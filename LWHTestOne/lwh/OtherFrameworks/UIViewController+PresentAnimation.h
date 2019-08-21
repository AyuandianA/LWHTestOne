//
//  UIViewController+Extension.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/18.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (PresentAnimation)

///是否存在这个present自定义动画，如果不是调用bd_present的方式则为no
@property (nonatomic, assign,readonly)BOOL presentAnimation;
///默认为nil ,如果调用了bd_present后，则被presnent的控制器则存在这个Key值，方便在delloc的时候将animator销毁
@property (nonatomic,copy,readonly)NSString *presentKey;

/**
 汽修宝典的特殊present样式，
 */
- (void)bd_presentViewController:(UIViewController*)controller animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)removePresentAnimator;

@end
