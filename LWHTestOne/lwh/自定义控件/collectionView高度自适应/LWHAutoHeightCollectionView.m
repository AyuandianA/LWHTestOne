//
//  LWHAutoHeightCollectionView.m
//  LWHTestOne
//
//  Created by 李武华 on 2020/5/17.
//  Copyright © 2020 BraveShine. All rights reserved.
//
//自动布局需要设置estimatedItemSize属性，同时删除代理方法-(CGSize)collectionView：(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
#import "LWHAutoHeightCollectionView.h"
@interface LWHAutoHeightCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation LWHAutoHeightCollectionView

+(instancetype)creatAutoHeightCollectionViewWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.estimatedItemSize = CGSizeMake(10, 10);
    return [[self alloc]initWithFrame:frame collectionViewLayout:layout];
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        //初始化自带属性
        [self chuShiHua];
    }
    return self;
}

//初始化自带属性
-(void)chuShiHua
{
    self.backgroundColor = [UIColor whiteColor];
    //注册collectionViewCell
    [self registerClass:[LWHAutoHeightCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCellId"];
    //设置代理
    self.delegate = self;
    self.dataSource = self;
    AdjustsScrollViewInsetNever([self viewController], self)
    
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.AutoHeightSourceArray.count) {
        return self.AutoHeightSourceArray.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWHAutoHeightCollectionViewCell *cell = (LWHAutoHeightCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellId" forIndexPath:indexPath];
    [cell AutoHeightViewModelss:self.AutoHeightSourceArray[indexPath.row]];
    
    return cell;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个Section的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
-(NSMutableArray *)AutoHeightSourceArray
{
    if (!_AutoHeightSourceArray) {
        _AutoHeightSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _AutoHeightSourceArray;
}

@end
