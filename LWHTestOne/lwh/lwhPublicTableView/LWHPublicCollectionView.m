//
//  LWHPublicCollectionView.m
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHPublicCollectionView.h"
@interface LWHPublicCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation LWHPublicCollectionView

+(instancetype)creatPublicCollectionViewWithFrame:(CGRect)frame
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
    self.cellName = @"LWHPublicCollectionViewCell";
    self.Hmargin = 0;
    self.Vmargin = 0;
    self.insets = UIEdgeInsetsZero;
    //注册collectionViewCell
    [self registerClass:[object_getClass(self.cellName) class] forCellWithReuseIdentifier:@"CollectionViewCellId"];
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
    if (self.PublicSourceArray.count) {
        return self.PublicSourceArray.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellId" forIndexPath:indexPath];
    id model = self.PublicSourceArray[indexPath.row];
    void (*actionTwo)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
    SEL selTwo = sel_registerName("changeDataWithModel:");
     actionTwo(cell,selTwo,model);
    return cell;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tapSection) {
        self.tapSection(indexPath);
    }
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.Hmargin;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.Vmargin;
}
//设置每个Section的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.insets;
}
-(NSMutableArray *)PublicSourceArray
{
    if (!_PublicSourceArray) {
        _PublicSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _PublicSourceArray;
}

@end
