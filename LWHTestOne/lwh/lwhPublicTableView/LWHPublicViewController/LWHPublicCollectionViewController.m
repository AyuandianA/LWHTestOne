//
//  LWHPublicCollectionViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHPublicCollectionViewController.h"
#import "BaseNaviController.h"
@interface LWHPublicCollectionViewController ()

@end

@implementation LWHPublicCollectionViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建控件
        [self ControllerKongJianBuJu];
    }
    return self;
}
#pragma mark 创建控件
-(void)ControllerKongJianBuJu
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

-(LWHPublicCollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [LWHPublicCollectionView creatPublicCollectionViewWithFrame:self.view.bounds];
        _collectionView.cellName = @"LWHPublicCollectionViewCell";
    }
    return _collectionView;
}

@end
