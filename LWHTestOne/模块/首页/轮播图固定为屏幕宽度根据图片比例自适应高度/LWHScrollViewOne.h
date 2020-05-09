//
//  LWHScrollViewOne.h
//  LWHTestOne
//
//  Created by 李武华 on 2020/5/7.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^heightChange)(CGFloat height);

@interface LWHScrollViewOne : UIScrollView
@property(nonatomic,strong)heightChange heightChange;
//初始化方法
-(instancetype)initWithFrame:(CGRect)frame andImagesScaleArray:(NSArray *)scaleArray andImagesNameArray:(NSArray *)nameArray;



@end

NS_ASSUME_NONNULL_END
