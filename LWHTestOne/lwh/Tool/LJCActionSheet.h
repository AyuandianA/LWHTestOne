//
//  LJCActionSheet.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/19.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJCActionSheet;

typedef enum {
    LJCActionSheetStyleDefault, // 正常字体样式
    LJCActionSheetStyleCancel,  // 粗体字样式
    LJCActionSheetStyleDestructive // 红色字体样式
} LJCActionSheetStyle;

//定义一个block
typedef void(^ClickBlock)(NSInteger index);


@protocol LJCActionSheetDelegate <NSObject>
/**
 *  代理方法
 *
 *  @param actionSheet actionSheet
 *  @param index       被点击按钮是哪个
 */
- (void)clickAction:(LJCActionSheet *)actionSheet atIndex:(NSUInteger)index sheetTitle:(NSString *)title;
@end

@interface LJCActionSheet : UIView

// 代理
@property (nonatomic, weak) id<LJCActionSheetDelegate> delegate;
/**
 *  初始化方法
 *
 *  @param title    提示内容
 *  @param confirms 选项标题数组
 *  @param cancel   取消按钮标题
 *  @param style    显示样式
 *
 *  @return         actionSheet
 */
+ (LJCActionSheet *)actionSheetWithTitle:(NSString *)title confirms:(NSArray *)confirms cancel:(NSString *)cancel style:(LJCActionSheetStyle)style;
// 带block的初始化方法
+ (LJCActionSheet *)actionSheetWithTitle:(NSString *)title confirms:(NSArray *)confirms cancel:(NSString *)cancel style:(LJCActionSheetStyle)style click:(ClickBlock)click;

/**
 *  显示方法
 *  @param obj UIView或者UIWindow类型
 */
- (void)showInView:(id)obj;
@end
