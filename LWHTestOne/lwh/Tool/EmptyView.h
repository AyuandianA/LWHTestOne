//
//  EmptyView.h
//  YiMeiZhiBo
//
//  Created by Aliang Ren on 2018/3/23.
//  Copyright © 2018年 史德萌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RefreshBlock)(void);

@interface EmptyView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImg:(NSString *)imgName;

//@property(strong, nonatomic)UIViewController *baseVc;

- (void)changeImageName:(NSString *)name frame:(CGSize)size title:(NSString *)tit;

@property(nonatomic,copy)RefreshBlock rBlock;

@end
