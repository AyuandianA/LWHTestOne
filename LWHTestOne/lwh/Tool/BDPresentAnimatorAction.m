//
//  BDPushAnimation.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/18.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "BDPresentAnimatorAction.h"

@implementation BDPresentAnimatorAction

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.40;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    switch (self.transformType) {
        case BDTransformPush:
            [self pushAnimationWithTransition:transitionContext];
            break;
        case BDTransformPop:
            [self popAnimationWithTransition:transitionContext];
            break;
        case BDTransformPresent:
            [self presentAnimationWithTransition:transitionContext];
            break;
        case BDTransformDismiss:
            [self dismissAnimationWithTransition:transitionContext];
            break;
            
        default:
            break;
    }
   
}

- (void)presentAnimationWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    [transitionContext.containerView addSubview:toView];
    
    CGFloat width = toView.bounds.size.width;
    CGFloat height = toView.bounds.size.height;
    toView.frame = CGRectMake(0, height, width, height);
    
    
    fromView.layer.zPosition = -1;
    CATransform3D scale = CATransform3DIdentity;
    // [UIScreen mainScreen].bounds.size.height == 812.0f?0.94:0.95
    // [UIScreen mainScreen].bounds.size.height == 812.0f?0.96:0.97
    scale = CATransform3DScale(scale, 1, 1, 1);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.layer.transform = scale;
        toView.frame = CGRectMake(0, 0, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        fromView.layer.zPosition = 0;
        fromView.layer.transform = CATransform3DIdentity;
    }];
    
}

- (void)dismissAnimationWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.frame = transitionContext.containerView.bounds;
    [transitionContext.containerView addSubview:toView];
    [transitionContext.containerView bringSubviewToFront:fromView];
    
    toView.layer.zPosition = -1;
    CATransform3D scale = CATransform3DIdentity;
    // [UIScreen mainScreen].bounds.size.height == 812.0f?0.94:0.95
    // [UIScreen mainScreen].bounds.size.height == 812.0f?0.96:0.97
    scale = CATransform3DScale(scale, 1, 1, 1);
    toView.layer.transform = scale;
    
    CGFloat width = toView.bounds.size.width;
    CGFloat height = toView.bounds.size.height;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(0, height, width, height);
        toView.layer.transform = CATransform3DIdentity;
        toView.layer.zPosition = 0;
    } completion:^(BOOL finished) {
        fromView.frame = CGRectMake(0, 0, width, height);
        toView.frame = CGRectMake(0, 0, width, height);
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)pushAnimationWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    [transitionContext.containerView addSubview:toView];
    
    CGFloat width = toView.bounds.size.width;
    CGFloat height = toView.bounds.size.height;
    toView.frame = CGRectMake(width, 0, width, height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

- (void)popAnimationWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.frame = transitionContext.containerView.bounds;
    [transitionContext.containerView addSubview:toView];
    [transitionContext.containerView bringSubviewToFront:fromView];
    
    CGFloat width = toView.bounds.size.width;
    CGFloat height = toView.bounds.size.height;
    toView.frame = CGRectMake(-width*0.35, 0, width, height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(width, 0, width, height);
        toView.frame = CGRectMake(0, 0, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}



@end
