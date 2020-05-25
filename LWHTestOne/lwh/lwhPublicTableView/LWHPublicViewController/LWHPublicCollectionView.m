//
//  LWHPublicCollectionView.m
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHPublicCollectionView.h"
#import "LWHPublicCollectionViewCell.h"
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
    //注册collectionViewCell
    [self registerClass:NSClassFromString(self.cellName) forCellWithReuseIdentifier:self.cellName];
    #pragma mark -- 注册头部视图
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HeaderView"];
    //设置代理
    self.delegate = self;
    self.dataSource = self;
    AdjustsScrollViewInsetNever([self viewController], self)
    
}
-(void)setCellName:(NSString *)cellName
{
    _cellName = cellName;
    [self registerClass:NSClassFromString(cellName) forCellWithReuseIdentifier:cellName];
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.cellSections) {
        return self.cellSections();
    }else{
        return 1;
    }
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.cellRows) {
        return self.cellRows(section);
    }else{
        if (self.PublicSourceArray.count != 0) {
            return self.PublicSourceArray.count;
        }else{
            return 0;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    void (*actionTwo)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
    void (*actionThree)(id, SEL, id,id) = (void (*)(id, SEL, id,id)) objc_msgSend;
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellName forIndexPath:indexPath];
    id model ;
    SEL selTwo;
    if (self.cellSections) {
        if (self.cellSections() > 1) {
            model = self.PublicSourceArray[indexPath.section][indexPath.row];
            selTwo = sel_registerName("changeDataWithModel:andSection:");
            actionThree(cell,selTwo,model,indexPath);
        }else{
            model = self.PublicSourceArray[indexPath.row];
            selTwo = sel_registerName("changeDataWithModel:");
            actionTwo(cell,selTwo,model);
        }
    }else{
        model = self.PublicSourceArray[indexPath.row];
        selTwo = sel_registerName("changeDataWithModel:");
        actionTwo(cell,selTwo,model);
    }
    return cell;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tapSection) {
        self.tapSection(indexPath);
    }
}
 //设置区头尺寸高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if (self.headerHeight) {
        height = self.headerHeight(section);
    }else{
        height = 0.01;
    }
    CGSize size = CGSizeMake(KScreenWidth, height);
    return size;
}
// 设置区尾尺寸高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat height = 0;
    if (self.footerHeight) {
        height = self.footerHeight(section);
    }else{
        height = 0.01;
    }
    CGSize size = CGSizeMake(KScreenWidth, height);
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *headerView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.9];
    return headerView;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.Hmargin) {
        return self.Hmargin(section);
    }else{
        return 0;
    }
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.Vmargin) {
        return self.Vmargin(section);
    }else{
        return 0;;
    }
}
//设置每个Section的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    if (self.insets) {
        return self.insets(section);
    }else{
        return UIEdgeInsetsZero;
    }
}
-(NSMutableArray *)PublicSourceArray
{
    if (!_PublicSourceArray) {
        _PublicSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _PublicSourceArray;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollSection) {
        self.scrollSection();
    }
}
@end
