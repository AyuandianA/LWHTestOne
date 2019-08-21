//
//  ChatHelper.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/8.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import "ChatHelper.h"
#import <YYKit/NSAttributedString+YYText.h>
#import <YYKit/YYImage.h>
#import "ChatFace.h"
#import "ChatFaceHeleper.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>


#define kTailStr    @"…"
#define kOpenStr    @"全文"
//#define kCloseStr   @"收起"

NSString *_content;

ChatHelper *_helper;

@interface ChatHelper()<LJCActionSheetDelegate>


@end

@implementation ChatHelper

+ (NSMutableAttributedString *) formatMessageString:(NSString *)string withTextColor:(UIColor *)color {
    _content = string;
    // 创建属性字符串
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TextFont],NSForegroundColorAttributeName:color}];
    _helper = [[self alloc]init];
    YYTextBorder *border = [[YYTextBorder alloc]init];
    border.cornerRadius = 3;
    border.insets = UIEdgeInsetsMake(0, -2, 0, -2);
//    border.fillColor = [UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:.5];
    
    YYTextHighlight *allHigh = [[YYTextHighlight alloc]init];
    [allHigh setBackgroundBorder:border];
    [allHigh setLongPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
        _content = string;
        LJCActionSheet *sheet = [LJCActionSheet actionSheetWithTitle:@"提示" confirms:@[@"复制文字"] cancel:@"取消" style:LJCActionSheetStyleDefault];
        sheet.delegate = _helper;

        [sheet showInView:[UIApplication sharedApplication].keyWindow];
        
    }];
    [attributedText setTextHighlight:allHigh range:attributedText.rangeOfAll];
    
    // 链接数组
    NSArray *arr = [self discriminateLink:string];
    // 表情数组
    NSArray *emojiArr = [self discriminateExpression:string];
//    // 电话数组
//    NSArray *phoneArr = [self discriminatePhone:string];
//    // 邮箱数组
//    NSArray *emailArr = [self discriminateEmail:string];
    //
//    for (NSTextCheckingResult *tel in phoneArr) {
//
//        NSString *phoneMatch = [string substringWithRange:tel.range];
//
//        NSMutableAttributedString *phoneStr = [[NSMutableAttributedString alloc] initWithString:phoneMatch];
//
//        phoneStr.color = [UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000];
//        phoneStr.font = [UIFont systemFontOfSize:TextFont];
//
//        YYTextHighlight *phoneHigh = [[YYTextHighlight alloc]init];
//        [phoneHigh setBackgroundBorder:border];
//        [phoneStr setTextHighlight:phoneHigh range:phoneStr.rangeOfAll];
//        [phoneHigh setTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//            
//            NSString *selectStr = [text.string substringWithRange:range];
//            
//            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",selectStr];
//            
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//            
//        }];
        
        
//        [attributedText replaceCharactersInRange:tel.range withAttributedString:phoneStr];
//
//    }
    //
//    for (NSTextCheckingResult *email in emailArr) {
//
//        NSString *emailMatch = [string substringWithRange:email.range];
//
//        NSMutableAttributedString *emailStr = [[NSMutableAttributedString alloc] initWithString:emailMatch];
//
//        emailStr.color = [UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000];
//        emailStr.font = [UIFont systemFontOfSize:TextFont];

//        YYTextHighlight *emailHigh = [[YYTextHighlight alloc]init];
//        [emailHigh setBackgroundBorder:border];
//        [emailStr setTextHighlight:emailHigh range:emailStr.rangeOfAll];
        //
//        [attributedText replaceCharactersInRange:email.range withAttributedString:emailStr];
//
//    }

    //
    for (NSTextCheckingResult *link in arr) {

        NSString *linkMatch = [string substringWithRange:link.range];

        NSMutableAttributedString *linkStr = [[NSMutableAttributedString alloc] initWithString:linkMatch];
        linkStr.color = [UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000];
        linkStr.font = [UIFont systemFontOfSize:TextFont];
        //
        YYTextHighlight *linkHigh = [[YYTextHighlight alloc]init];
        [linkHigh setBackgroundBorder:border];

        [linkStr setTextHighlight:linkHigh range:linkStr.rangeOfAll];
        //
        [attributedText replaceCharactersInRange:link.range withAttributedString:linkStr];

    }
    
    // 从后往前替换，避免因位置问题崩溃
    for (NSInteger i = emojiArr.count - 1; i >= 0; i--) {

        NSRange range;

        [emojiArr[i][@"range"] getValue:&range];
       
        UIImage *image = [UIImage imageNamed:emojiArr[i][@"name"]];

        NSMutableAttributedString *attachText= [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(TextFont+3, TextFont+3) alignToFont:[UIFont systemFontOfSize:TextFont] alignment:YYTextVerticalAlignmentCenter];
        
        // 进行替换
        [attributedText replaceCharactersInRange:range withAttributedString:attachText];

    }
    // 行间隙
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedText.string length])];
    
    return attributedText;
 
}
// 识别链接
+ (NSArray *)discriminateLink:(NSString *)content {
    
    NSError *error;
    
    //识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:content options:0 range:NSMakeRange(0, [content length])];
    
    
    return arrayOfAllMatches;
    
}
// 识别表情
+ (NSArray *)discriminateExpression:(NSString *)content {
    
    // 正则匹配
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]";
    
    NSError *err = nil;
    
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&err];
    
    NSArray *resultArray = [re matchesInString:content options:0 range:NSMakeRange(0, content.length)];
    
    //存储图片和图片对应位置 的字典
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    //根据匹配范围用图片进行替换
    for (NSTextCheckingResult *match in resultArray) {
        // 数组元素中得到range
        NSRange range = [match range];
        // 原字符串中对应的值
        NSString *subStr = [content substringWithRange:range];
        
        NSArray *group = [[ChatFaceHeleper  sharedFaceHelper] getFaceArrayByGroupID:@"normal_face"];
        
        for (ChatFace *face in group) {
            
            if ([face.faceName isEqualToString:subStr]) {
                //                NSLog(@"-------%@",face.faceName);

                //把图片和图片对应的位置存入字典
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
//                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:face.faceName forKey:@"name"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
                
            }
        }
    }
    
    return [NSArray arrayWithArray:imageArray];
    
}
// 识别电话
+ (NSArray *)discriminatePhone:(NSString *)content {
    
    NSString *expressionString = @"((?<=\\D)|^)((1+\\d{10})|(0+\\d{2,3}-\\d{7,8}|\\d{7,8}))((?=\\D)|$)";
    
    NSError *error;
    
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:expressionString options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *arrayOfAllMatches = [expression matchesInString:content options:0 range:NSMakeRange(0, [content length])];
    
    return arrayOfAllMatches;
    
}
// 识别邮箱
+ (NSArray *)discriminateEmail:(NSString *)content {
    
    NSString *expressionString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSError *error;
    
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:expressionString options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *arrayOfAllMatches = [expression matchesInString:content options:0 range:NSMakeRange(0, [content length])];
    
    return arrayOfAllMatches;
    
}

+ (NSMutableAttributedString *)createMessageAttributedString:(NSString *)text {
    
    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    // 行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:3];
    YYTextBorder *border = [[YYTextBorder alloc]init];
    border.cornerRadius = 3;
    border.insets = UIEdgeInsetsMake(0, -2, 0, -2);
    border.fillColor = [UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:.5];
    
    // 链接数组
    NSArray *arr = [self discriminateLink:text];
    // 表情数组
    NSArray *emojiArr = [self discriminateExpression:text];
    // 电话数组
//    NSArray *phoneArr = [self discriminatePhone:text];
    // 邮箱数组
//    NSArray *emailArr = [self discriminateEmail:text];
    //
//    for (NSTextCheckingResult *tel in phoneArr) {
//
//        NSString *phoneMatch = [text substringWithRange:tel.range];
//        NSLog(@"--%@",phoneMatch);
//        NSMutableAttributedString *phoneStr = [[NSMutableAttributedString alloc] initWithString:phoneMatch];
//
//        phoneStr.color = [UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000];
//        phoneStr.font = [UIFont systemFontOfSize:TextFont];
//
//        YYTextHighlight *phoneHigh = [[YYTextHighlight alloc]init];
//        [phoneHigh setBackgroundBorder:border];
//        [phoneStr setTextHighlight:phoneHigh range:phoneStr.rangeOfAll];
//        [phoneHigh setTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//
//            NSString *selectStr = [text.string substringWithRange:range];
//            NSLog(@"---%@",selectStr);
//            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",selectStr];
//
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//
//        }];
//
//        [attributeString replaceCharactersInRange:tel.range withAttributedString:phoneStr];
//
//    }
    //
//    for (NSTextCheckingResult *email in emailArr) {
//
//        NSString *emailMatch = [text substringWithRange:email.range];
//
//        NSMutableAttributedString *emailStr = [[NSMutableAttributedString alloc] initWithString:emailMatch];
//
//        emailStr.color = [UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000];
//        emailStr.font = [UIFont systemFontOfSize:TextFont];
    
        //        YYTextHighlight *emailHigh = [[YYTextHighlight alloc]init];
        //        [emailHigh setBackgroundBorder:border];
        //        [emailStr setTextHighlight:emailHigh range:emailStr.rangeOfAll];
        //
//        [attributeString replaceCharactersInRange:email.range withAttributedString:emailStr];
//        
//    }
    
    //
    for (NSTextCheckingResult *link in arr) {
        
        NSString *linkMatch = [text substringWithRange:link.range];
        
        NSMutableAttributedString *linkStr = [[NSMutableAttributedString alloc] initWithString:linkMatch];
        linkStr.color = [UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000];
        linkStr.font = [UIFont systemFontOfSize:TextFont];
        //
        YYTextHighlight *linkHigh = [[YYTextHighlight alloc]init];
        [linkHigh setBackgroundBorder:border];
        [linkHigh setTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            
            if (range.location <= text.length) {
                
                NSString *selectStr = [text.string substringWithRange:range];
                
                if ([selectStr containsString:@"http"]) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:selectStr]];
                    
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",selectStr]]];
                }
                
            }
           
        }];
        //
        [attributeString replaceCharactersInRange:link.range withAttributedString:linkStr];
        
    }
    
    // 从后往前替换，避免因位置问题崩溃
    for (NSInteger i = emojiArr.count - 1; i >= 0; i--) {
        
        NSRange range;
        
        [emojiArr[i][@"range"] getValue:&range];
        
        UIImage *image = [UIImage imageNamed:emojiArr[i][@"name"]];
        
        NSMutableAttributedString *attachText= [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(TextFont+3, TextFont+3) alignToFont:[UIFont systemFontOfSize:TextFont] alignment:YYTextVerticalAlignmentCenter];
        
        // 进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:attachText];
        
    }
    
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributeString length])];
    
    attributeString.font = [UIFont systemFontOfSize:TextFont];
    
    
    return attributeString;
    
}

- (void)clickAction:(LJCActionSheet *)actionSheet atIndex:(NSUInteger)index sheetTitle:(NSString *)title {
    
    if (index == 0) {
        
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        
        pasteBoard.string = _content;
        
    }
    
}

@end
