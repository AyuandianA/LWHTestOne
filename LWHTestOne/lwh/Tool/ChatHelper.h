//
//  ChatHelper.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/8.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ChatHelper : NSObject

@property (nonatomic, strong) NSMutableArray *faceGroupArray;

// YYLabel用
+ (NSMutableAttributedString *) formatMessageString:(NSString *)text withTextColor:(UIColor *)color;
// UITextView 用

+ (NSMutableAttributedString *)createMessageAttributedString:(NSString *)text;

@end
