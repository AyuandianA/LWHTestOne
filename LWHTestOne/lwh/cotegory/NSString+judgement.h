//
//  NSString+phone.h
//  CollectFans
//
//  Created by 李威 on 16/12/24.
//  Copyright © 2016年 liwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (judgement)

- (BOOL)isPhoneNummber; // 判断字符串是否是手机号
- (BOOL)isTelPhone; // 判断字符串是否是电话
- (BOOL)isWebUrl; // 判断字符串是否是链接
- (BOOL)isEmail; // 判断字符串是否是邮箱
- (BOOL)isContainEmpty; // 判断字符串是否包含空格
- (BOOL)isContainChinese; // 判断字符串是否包含中文
- (BOOL)isEmptyString; // 判断字符串是否为空
- (CGFloat)getStringLength:(int)font; // 根据字号计算字符串长度
- (CGFloat)getStringLengthWithFont:(UIFont *)font; // 根据字体计算字符串长度
- (CGFloat)getStringHeight:(CGFloat)textWidth withTextFont:(CGFloat)textFont; // 计算字符串高度
- (CGRect)getStrRectWidth:(CGFloat)textWidth withTextFont:(CGFloat)font;

@end
