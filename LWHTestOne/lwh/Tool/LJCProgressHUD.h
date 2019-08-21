//
//  LJCProgressHUD.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/11.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJCProgressHUD : NSObject
// 菊花样式
+ (void)showIndicator;
// 菊花样式带提示
+ (void)showIndicatorWithText:(NSString *)text;
// 环形进度显示
+ (void)showAnnulusHud;
// 状态提示(纯文本)
+ (void)showStatueText:(NSString *)text;
// 错误状态提示(带图片)
+ (void)showErrorText:(NSString *)text;
// 成功状态提示(带图片)
+ (void)showSuccText:(NSString *)text;
// 隐藏提示框
+ (void)hiddenHud;

@end

NS_ASSUME_NONNULL_END
