//
//  UIViewController+Extension.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/18.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "UIViewController+PresentAnimation.h"
#import "BDPresentAnimator.h"
#import <objc/runtime.h>

@implementation UIViewController (PresentAnimation)

- (void)bd_presentViewController:(UIViewController*)controller animated:(BOOL)animated completion:(void (^)(void))completion
{
    BDPresentAnimator *animator =  [[BDPresentAnimator alloc]init];
    controller.transitioningDelegate = animator;
    animator.controller = controller;
    controller.presentAnimation = true;
    
    NSString *className = NSStringFromClass(controller.class);
    // 保证key值唯一性
    NSString *sourceKey = [NSString stringWithFormat:@"%@_%p",className,controller];
    controller.presentKey = sourceKey;
    [[BDPresentAnimatorManager manager] addAnimaor:animator withKey:sourceKey];
    // 添加手势
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:animator action:NSSelectorFromString(@"edgePanAction:")];
    edgePan.edges = UIRectEdgeLeft;
    [controller.view addGestureRecognizer:edgePan];
    
    [self presentViewController:controller animated:animated completion:completion];
    
}

//runtime 动态绑定 属性
- (void)setPresentAnimation:(BOOL)presentAnimation{
    // BOOL类型 需用OBJC_ASSOCIATION_RETAIN_NONATOMIC，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(presentAnimation), @(presentAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)presentAnimation {
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}


-(void)setPresentKey:(NSString *)presentKey {
    objc_setAssociatedObject(self, @selector(presentKey), presentKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

-(NSString *)presentKey {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)removePresentAnimator {
    [[BDPresentAnimatorManager manager] removeAnimatorWithController:self];
}


@end

