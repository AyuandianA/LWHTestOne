//
//  NSString+phone.m
//  CollectFans
//
//  Created by 李威 on 16/12/24.
//  Copyright © 2016年 liwei. All rights reserved.
//

#import "NSString+judgement.h"

@implementation NSString (judgement)

// 判断字符串是否是手机号
- (BOOL)isPhoneNummber {
    
    if (self.length != 11) {
        
        return NO;
        
    } else {
        
        NSString *regex = @"[0-9]*";
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if ([pred evaluateWithObject:self]) {
            
            return YES;
        }
        
        return NO;
        
    }
    
    // 判断字符串是否是手机号
    
    
    
}
- (BOOL)isTelPhone {
    
    NSString *expressionString = @"((?<=\\D)|^)((1+\\d{10})|(0+\\d{2,3}-\\d{7,8}|\\d{7,8}))((?=\\D)|$)";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",expressionString];
    
    if ([pred evaluateWithObject:self]) {
        
        return YES;
    }
    
    return NO;
    
}
- (BOOL)isWebUrl {
    
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regulaStr];
    
    if ([pred evaluateWithObject:self]) {
        
        return YES;
    }
    
    return NO;
    
}
- (BOOL)isEmail {
    
    NSString *expressionString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",expressionString];
    
    if ([pred evaluateWithObject:self]) {
        
        return YES;
    }
    
    return NO;
    
}
// 判断字符串是否包含空格
-(BOOL)isContainEmpty {
    
    NSRange range = [self rangeOfString:@" "];
    
    if (range.location != NSNotFound) {
        
        return YES; //yes代表包含空格
        
    } else {
        
        return NO; //反之
    }
}
// 判断字符串是否包含中文
- (BOOL)isContainChinese {
    
    for(int i = 0; i < [self length];i++) {
        
        int a = [self characterAtIndex:i];
        // 0x4e00 0x9fff(0x9fa5)
        if( a > 0x4e00&& a < 0x9fff){
            
            return YES;
        }
    }
    
    return NO;
}
// 判断字符串是否为空
- (BOOL)isEmptyString {
    
    if ([self isEqualToString:@""] || self == nil || [self isKindOfClass:[NSNull class]] || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"] || [self isEqualToString:@"null"] || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        
        return YES;
    }
    
    return NO;
    
}
// 根据字号计算字符串长度
- (CGFloat)getStringLength:(int)font {
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    return rect.size.width;
    
}
// 根据字体计算字符串长度
- (CGFloat)getStringLengthWithFont:(UIFont *)font {
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return rect.size.width;
    
}
// 计算字符串高度
- (CGFloat)getStringHeight:(CGFloat)textWidth withTextFont:(CGFloat)textFont {
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]} context:nil];
    
    return rect.size.height;
    
}
- (CGRect)getStrRectWidth:(CGFloat)textWidth withTextFont:(CGFloat)font {
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    return rect;
}




@end
