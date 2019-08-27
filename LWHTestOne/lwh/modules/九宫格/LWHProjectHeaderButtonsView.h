//
//  LWHProjectHeaderView.h
//  ChengXianApp
//
//  Created by mac on 2019/6/26.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^projectHeaderBlock)(NSInteger index);
@interface LWHProjectHeaderButtonsView : UIView

@property (nonatomic,copy) projectHeaderBlock myBlock;

-(instancetype)initWithLineNum:(NSInteger)lineNum colunmNum:(NSInteger)columnNum scaleHeightAndWidth:(CGFloat)ScaleHeightAndWidth;
//文字和图片
- (CGFloat)creatButtonViewsWithDataSourceArray:(NSArray *)stringsArray andImagesArray:(NSArray *)imagesArray;
//文字
- (CGFloat)creatLableViewsWithDataSourceArray:(NSArray *)stringsArray;
@end

NS_ASSUME_NONNULL_END
