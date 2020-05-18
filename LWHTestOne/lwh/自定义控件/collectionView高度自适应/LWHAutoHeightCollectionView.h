//
//  LWHAutoHeightCollectionView.h
//  LWHTestOne
//
//  Created by 李武华 on 2020/5/17.
//  Copyright © 2020 BraveShine. All rights reserved.
//


#import "LWHAutoHeightCollectionViewCell.h"

@interface LWHAutoHeightCollectionView : UICollectionView

@property (nonatomic,strong) NSMutableArray *AutoHeightSourceArray;

+(instancetype)creatAutoHeightCollectionViewWithFrame:(CGRect)frame;

@end
