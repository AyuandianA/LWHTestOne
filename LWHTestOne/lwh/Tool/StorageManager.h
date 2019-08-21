//
//  StorageManager.h
//  YiMeiZhiBo
//
//  Created by Aliang Ren on 2018/6/16.
//  Copyright © 2018年 史德萌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageManager : NSObject
// 存
+ (void)setObj:(id)obj forKey:(NSString *)key;
// 取
+ (id)objForKey:(NSString *)key;
// 删
+ (void)removeKey:(NSString *)key;

@end
