//
//  LWHWalletHeaderView.m
//  LWHTestOne
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import "LWHWalletHeaderView.h"

#import "UIImage+Category.h"
@interface LWHWalletHeaderView ()
@property (nonatomic,strong) UIImageView *imageView;
//@property (nonatomic,strong) <#类型#> *<#属性#>;
@end
@implementation LWHWalletHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self chuShiHuaSubViews];
    }
    return self;
}
+(instancetype)standardWalletHeaderViewWithFrame:(CGRect)frame
{
    return [[self alloc]initWithFrame:frame];
}
//初始化数据
-(void)chuShiHuaSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    //创建子控件
    
    UIImageView *imageView = [[UIImageView alloc]init];
    self.imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage convertViewToImage];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.layer.cornerRadius = 5;
    [self addSubview:imageView];
    //更新子控件vframe
    [self setUpSubviewsFrame];
}


-(void)setWalletHeaderViewModel:(LWHWalletHeaderViewModel *)WalletHeaderViewModel
{
    _WalletHeaderViewModel = WalletHeaderViewModel;
    LWHWalletHeaderModel *Model = WalletHeaderViewModel.WalletHeaderModel;
    //    属性赋值
    
    //    控件高度
    
    //更新frame
    [self setUpSubviewsFrame];
}
-(void)setUpSubviewsFrame
{
    self.imageView.frame = CGRectMake(0, 0, KScreenWidth, self.height);
}

@end

