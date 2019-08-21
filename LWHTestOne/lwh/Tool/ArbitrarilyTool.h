//
//  ArbitrarilyTool.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/7/12.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArbitrarilyTool : NSObject

// 任意跳转:  vcName 类名  dic 携带参数
+ (void)atWillPush:(NSString *)vcName withModelName:(NSString *)modelName withModelParam:(NSString *)modelParam dic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
