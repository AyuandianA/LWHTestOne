//
//  LWHPublicCollectionView.h
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//



typedef void(^tapSection)(NSIndexPath *indexPath);
@interface LWHPublicCollectionView : UICollectionView

@property (nonatomic,strong) NSMutableArray *PublicSourceArray;

@property (nonatomic,copy) NSString *cellName;
@property (nonatomic,assign) UIEdgeInsets insets;
@property (nonatomic,assign) CGFloat Hmargin;
@property (nonatomic,assign) CGFloat Vmargin;
@property (nonatomic,copy) tapSection tapSection;
+(instancetype)creatPublicCollectionViewWithFrame:(CGRect)frame;

@end
