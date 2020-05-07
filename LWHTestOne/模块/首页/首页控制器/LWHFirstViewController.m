//
//  LWHFirstViewController.m
//  LWHTestOne
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import "LWHFirstViewController.h"
#import "BaseNaviController.h"
#import "UIImage+Category.h"
#import "UIImage+Category.h"
#import "LWHTarbarView.h"


@interface LWHFirstViewController ()<UIScrollViewDelegate>
//表视图头视图
@property (nonatomic,strong) UIView *headerView;
//轮播图背景滚动图
@property (nonatomic,strong) UIScrollView *sdchcleView;
//展示列表
@property (nonatomic,strong) UITableView *tableView;
//表视图数据源
@property (nonatomic,strong) NSMutableArray *dataArray;
//图片视图集合
@property (nonatomic,strong) NSMutableArray *imageSArray;
//图片视图集合背景视图
@property (nonatomic,strong) UIView *imagesBackView;
//图片宽高比集合
@property (nonatomic,copy) NSArray *scaleArray;
@end

@implementation LWHFirstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenReturnButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.scaleArray = @[@(366.0/638),@(626.0/636),@(1092.0/642)];
    self.imageSArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.headerView];
}

-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView  alloc]init];
        _headerView.backgroundColor = [UIColor blueColor];
        UIScrollView *sdchcleView = [[UIScrollView alloc]init];
        self.sdchcleView = sdchcleView;
        sdchcleView.delegate = self;
        sdchcleView.pagingEnabled = YES;
        sdchcleView.alwaysBounceVertical = YES;
        sdchcleView.bounces = NO;
        sdchcleView.backgroundColor = [UIColor redColor];
        [_headerView addSubview:sdchcleView];
        NSArray *imagesName = @[@"11",@"22",@"33"];
        self.imagesBackView = [[UIView alloc]init];
        self.imagesBackView.backgroundColor = [UIColor greenColor];
        [sdchcleView addSubview:self.imagesBackView];
        for (NSString *imageName in imagesName) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:imageName];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.imageSArray addObject:imageView];
            [self.imagesBackView addSubview:imageView];
        }
        
        //初始化头视图及子控件布局
        CGFloat scale = [self.scaleArray[0] floatValue];
        CGFloat height = scale * KScreenWidth;
        _headerView.frame = CGRectMake(0, 100, KScreenWidth, height + 100);
        sdchcleView.frame = CGRectMake(0, 0, KScreenWidth, height);
        sdchcleView.contentSize = CGSizeMake(KScreenWidth * imagesName.count, height);
        [self imagesFrameArrayWithHeight:height andIndex:0 andX:0];
        
    }
    return _headerView;
}

-(void)imagesFrameArrayWithHeight:(CGFloat)height andIndex:(int)index andX:(CGFloat)X
{
        
        double backWidth = 0;
        double backX = 0;
        for (int i = 0; i < self.scaleArray.count; i++) {
            double widthFrame = height / [self.scaleArray[i] doubleValue] ;
            CGRect frame = CGRectMake(backWidth, 0, widthFrame, height);
            if (i==index) {
                backX = KScreenWidth * index - backWidth ;
            }
            backWidth += widthFrame;
            UIImageView *imageView = self.imageSArray[i];
            imageView.frame = frame;;
            
        }
        self.imagesBackView.frame = CGRectMake(backX - X, 0, backWidth, height);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int i = scrollView.contentOffset.x / KScreenWidth;
    double X = scrollView.contentOffset.x  -  KScreenWidth * i;
    double scale = [self.scaleArray[i] floatValue];
    double height = scale * KScreenWidth  + (X / KScreenWidth) *   scale * KScreenWidth ;
    self.sdchcleView.height = height;
    self.sdchcleView.contentSize = CGSizeMake(self.sdchcleView.contentSize.width, height);
    self.headerView.height = height + 100;
    
    [self imagesFrameArrayWithHeight:height andIndex:i andX:X];
}

@end
