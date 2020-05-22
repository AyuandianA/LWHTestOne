//
//  BaseTabbarController.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/6.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import "BaseTabbarController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "BaseNaviController.h"
#import "LSNavigationController.h"
#import "CZSocketManager.h"
#import "UIViewController+PresentAnimation.h"
#import "LWHSouSuoCourseViewController.h"
#import "LWHComplexScrollerViewController.h"
#import "LWHComplexSubViewController.h"
#import "LWHTeacherListTwoViewController.h"
@interface BaseTabbarController ()<UITabBarControllerDelegate,CZSocketManagerDelegate> {
     NSString *_message_id;
}

@end

@implementation BaseTabbarController


- (UIView *)redPoint {
    if (!_redPoint) {
        _redPoint = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2+(kScreenWidth/4-20)/2+20, 5, 7, 7)];
        _redPoint.backgroundColor = [UIColor redColor];
        _redPoint.layer.cornerRadius = 3.5f;
        _redPoint.layer.masksToBounds = YES;
        _redPoint.hidden = YES;
    }
    return _redPoint;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.delegate = self;
    
    if (self.redPoint.hidden) {
        if ([StorageManager objForKey:@"Badge_Number"] && [[StorageManager objForKey:@"Badge_Number"] integerValue] > 0) {
            self.redPoint.hidden = NO;
        }
        
    }
    
    
    // 修改TabBar背景色
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    // 取消TabBar透明效果
    [UITabBar appearance].translucent = NO;
    
    [self _createSubCtrls];
    
    [self.tabBar addSubview:self.redPoint];
    
    [CZSocketManager shareSocket].delegate = self;
    
//    [[UserMaterialModel shareUser] upDataUserInfo];
    
}

- (void)_createSubCtrls {
    
    NSArray *controllerArr;
    
    NSMutableArray *navArr = [NSMutableArray array];
    

    //第三级控制器
    LWHSouSuoCourseViewController *homeCtrl = [[LWHSouSuoCourseViewController alloc] init];
    
    LWHComplexScrollerViewController *messgeCtrl = [[LWHComplexScrollerViewController alloc] init];
    
    LWHComplexSubViewController *findCtrl = [[LWHComplexSubViewController alloc] init];
    
    LWHTeacherListTwoViewController *meCtrl = [[LWHTeacherListTwoViewController alloc] init];
    
    controllerArr = @[homeCtrl,messgeCtrl,findCtrl,meCtrl];
    
    // 按钮标题
    NSArray *buttonTitles = @[@"找医生",@"查项目",@"消息",@"我的"];
    // 普通状态下按钮图片
    NSArray *buttonImages = @[@"doctor_normal.png",@"project_normal.png",@"message_normal.png",@"mine_normal.png"];
    // 选中状态下按钮图片
    NSArray *array = @[@"doctor_select.png",@"project_select.png",@"message_select.png",@"mine_select.png"];
    
    //二级控制器
    for (int i = 0; i < controllerArr.count; i++) {
        
        BaseNaviController *navCtrl = [[BaseNaviController alloc] initWithRootViewController:controllerArr[i]];
        UITabBarItem *item = navCtrl.tabBarItem;
        item.title = buttonTitles[i];
        item.image = [BundleTabeImage(buttonImages[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [BundleTabeImage(array[i]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; //
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:MainTopColor} forState:UIControlStateSelected];
        [navArr addObject:navCtrl];
        
    }
    
    //把导航控制器交给标签控制器管理
    self.viewControllers = navArr;
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (tabBarController.selectedIndex == 2) {
        
        if (!self.redPoint.hidden) {
            self.redPoint.hidden = YES;
        }
        
    }
    
}
// 获取当前控制器
- (UIViewController *)getCurrentVC {
    
    UIViewController *result = nil;

    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;

    do {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)rootVC;
            UIViewController *vc = [navi.viewControllers lastObject];
            result = vc;
            rootVC = vc.presentedViewController;
            continue;
        } else if([rootVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)rootVC;
            result = tab;
            rootVC = [tab.viewControllers objectAtIndex:tab.selectedIndex];
            continue;
        } else if([rootVC isKindOfClass:[UIViewController class]]) {
            result = rootVC;
            rootVC = nil;
        }
    } while (rootVC != nil);

    return result;
}

- (void)didReceiveMessageData:(NSDictionary *)messageDic {
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:Receive_Message object:nil userInfo:messageDic];
    
    if ([[NSString stringWithFormat:@"%@",messageDic[@"type"]] isEqualToString:@"recall"]) {
        return;
    }
    
    if (self.selectedIndex == 2) {
        if (!self.redPoint.hidden) {
            self.redPoint.hidden = YES;
        }
    }
    
    if ([messageDic[@"servicegroupid"] longLongValue] > 0) {
        
        if (_message_id) {
            
            if (([_message_id longLongValue] != [messageDic[@"id"] longLongValue])) {
                
                if ([messageDic[@"user_id"] integerValue] != [User_Id integerValue]) {
                    
                    _message_id = messageDic[@"id"];
                    
                    [self playSound];
                }
                
            }
            
        } else {
            
            _message_id = messageDic[@"id"];
            
            [self playSound];
          
        }
        
    } else {
        
        _message_id = messageDic[@"id"];
        
        [self playSound];
        
    }
   
}

- (void)playSound {
    
    NSString *badge = [NSString stringWithFormat:@"%ld",[[StorageManager objForKey:@"Badge_Number"] integerValue] + 1];
    [StorageManager setObj:badge forKey:@"Badge_Number"];
    [UIApplication sharedApplication].applicationIconBadgeNumber = [badge integerValue];
    
    AudioServicesPlaySystemSound(1007);
    
    if (self.redPoint.hidden) {
        self.redPoint.hidden = NO;
    }
    
}

@end
