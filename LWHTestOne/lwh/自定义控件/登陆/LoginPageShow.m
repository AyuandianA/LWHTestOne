//
//  LoginPageShow.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/18.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "LoginPageShow.h"
#import "BaseNaviController.h"
#import "LoginViewController.h"
#import "UIViewController+PresentAnimation.h"

@implementation LoginPageShow

+ (BOOL)showLogin:(UIViewController *)currentVc {
    
    if (!User_Id || [[NSString stringWithFormat:@"%@",User_Id] isEmptyString]) {
    
        LoginViewController *vc = [[LoginViewController alloc]init];
    
        vc.type = 1;
    
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
        BaseNaviController *navi = [[BaseNaviController alloc]initWithRootViewController:vc];
        
        [currentVc bd_presentViewController:navi animated:YES completion:nil];
        
        return NO;
        
    }
    
    return YES;

}

// 获取当前控制器
//+ (UIViewController *)currentViewController {
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    // modal展现方式的底层视图不同
//    // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
//    UIView *firstView = [keyWindow.subviews firstObject];
//    UIView *secondView = [firstView.subviews firstObject];
//    UIViewController *vc = nil;
//    UIResponder *responder = [secondView nextResponder];
//    while (responder) {
//        if ([responder isKindOfClass:[UIViewController class]]) {
//            vc = (UIViewController *)responder;
//        }
//        responder = [responder nextResponder];
//    }
//    //    UIViewController *vc = [secondView parentController];
//    if ([vc isKindOfClass:[UITabBarController class]]) {
//        UITabBarController *tab = (UITabBarController *)vc;
//        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
//            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
//            return [nav.viewControllers lastObject];
//        } else {
//            return tab.selectedViewController;
//        }
//    } else if ([vc isKindOfClass:[UINavigationController class]]) {
//        UINavigationController *nav = (UINavigationController *)vc;
//        return [nav.viewControllers lastObject];
//    } else {
//        return vc;
//    }
//    return nil;
//}

@end
