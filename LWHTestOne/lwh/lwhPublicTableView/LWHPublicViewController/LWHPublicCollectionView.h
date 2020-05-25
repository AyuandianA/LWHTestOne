//
//  LWHPublicCollectionView.h
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//



typedef void(^tapSection)(NSIndexPath *indexPath);
typedef void(^scrollSection)(void);
typedef UIEdgeInsets(^insets)(NSInteger section);
typedef CGFloat(^Hmargin)(NSInteger section);
typedef CGFloat(^Vmargin)(NSInteger section);
typedef CGFloat(^headerHeight)(NSInteger section);
typedef UIView *(^headerView)(NSInteger section);
typedef CGFloat(^footerHeight)(NSInteger section);
typedef UIView *(^footerView)(NSInteger section);
typedef NSInteger(^cellSections)(void);
typedef NSInteger(^cellRows)(NSInteger section);

@interface LWHPublicCollectionView : UICollectionView

@property (nonatomic,strong) NSMutableArray *PublicSourceArray;

@property (nonatomic,copy) NSString *cellName;

@property (nonatomic,copy) insets insets;
@property (nonatomic,copy) Hmargin Hmargin;
@property (nonatomic,copy) Vmargin Vmargin;

@property (nonatomic,copy) tapSection tapSection;
@property (nonatomic,copy) scrollSection scrollSection;
@property (nonatomic,copy) cellSections cellSections;
@property (nonatomic,copy) cellRows cellRows;
@property (nonatomic,copy) headerHeight headerHeight;
@property (nonatomic,copy) footerHeight footerHeight;
//@property (nonatomic,copy) footerView footerView;
//@property (nonatomic,copy) headerView headerView;
+(instancetype)creatPublicCollectionViewWithFrame:(CGRect)frame;

@end
