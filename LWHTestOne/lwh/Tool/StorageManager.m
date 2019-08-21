//
//  StorageManager.m
//  YiMeiZhiBo
//
//  Created by Aliang Ren on 2018/6/16.
//  Copyright © 2018年 史德萌. All rights reserved.
//

#import "StorageManager.h"

@implementation StorageManager

+ (void)setObj:(id)obj forKey:(NSString *)key {
    if (!key) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:[NSString stringWithFormat:@"%@",key]];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+ (id)objForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",key]];
}
+ (void)removeKey:(NSString *)key {
    if (!key) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@",key]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
