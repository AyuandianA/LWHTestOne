//
//  IssueDynamicToolBar.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/8/1.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ChatFace;
@class IssueDynamicToolBar;
@class CustomerTextView;

@protocol IssueDynamicToolBarDelegate <NSObject>
// 收起
- (void)commentBoxDidDisappear;

@end

@interface IssueDynamicToolBar : UIButton

- (instancetype)initWithTextView:(CustomerTextView *)textView;

- (void)hiddenView;

@property (nonatomic, assign) id<IssueDynamicToolBarDelegate>delegate;

@property (nonatomic, strong) NSString *placeHolder;  //输入框占位符



@end

NS_ASSUME_NONNULL_END
