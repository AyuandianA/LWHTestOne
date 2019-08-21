//
//  ArbitrarilyTool.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/12.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "ArbitrarilyTool.h"

@implementation ArbitrarilyTool

// 任意跳转:  vcName 类名  dic 携带参数
+ (void)atWillPush:(NSString *)vcName withModelName:(NSString *)modelName withModelParam:(NSString *)modelParam dic:(NSDictionary *)dic {
    
    if (![modelName isEmptyString]) {
        
        Class modelClass = NSClassFromString(modelName);
        
        // 创建对象
        id instance = [[modelClass alloc] init];
        //        [ ]
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
                // 通过kvc给属性赋值
                [instance setValue:obj forKey:key];
            } else {
//                NSLog(@"不包含key=%@的属性",key);
            }
        }];
        
        Class cls = NSClassFromString(vcName);
        UIViewController *vc = [[cls alloc] init];
        // 传值
        NSDictionary *dataDic = @{modelParam:instance};
        [dataDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
                // 通过kvc给属性赋值
                [instance setValue:obj forKey:key];
            } else {
//                NSLog(@"不包含key=%@的属性",key);
            }
        }];
        [[self getCurrentVC].navigationController pushViewController:vc animated:YES];
        
    } else {
        
        Class cls = NSClassFromString(vcName);
        UIViewController *vc = [[cls alloc] init];
        // 传值
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([self checkIsExistPropertyWithInstance:vc verifyPropertyName:key]) {
                // 通过kvc给属性赋值
                [vc setValue:obj forKey:key];
            } else {
//                NSLog(@"不包含key=%@的属性",key);
            }
        }];
        [[self getCurrentVC].navigationController pushViewController:vc animated:YES];
        
    }
    
}

/**
 *  检测对象是否存在该属性
 */
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName {
    
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        // 属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}

// 获取当前控制器
+ (UIViewController *)getCurrentVC {
    
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

@end
