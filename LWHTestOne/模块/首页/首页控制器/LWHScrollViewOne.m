//
//  LWHScrollViewOne.m
//  LWHTestOne
//
//  Created by 李武华 on 2020/5/7.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHScrollViewOne.h"

@interface LWHScrollViewOne ()<UIScrollViewDelegate>
//图片视图集合
@property (nonatomic,strong) NSMutableArray *imageSArray;
//图片视图集合背景视图
@property (nonatomic,strong) UIView *imagesBackView;
//图片宽高比集合
@property (nonatomic,copy) NSArray *scaleArray;
//图片url集合
@property (nonatomic,copy) NSArray *imagesName;
@end

@implementation LWHScrollViewOne

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame andImagesScaleArray:(NSArray *)scaleArray andImagesNameArray:(NSArray *)nameArray
{
    if (self = [super initWithFrame:frame]) {
        self.scaleArray = scaleArray;
        self.imagesName = nameArray;
        
        self.delegate = self;
        self.pagingEnabled = YES;
        self.alwaysBounceVertical = YES;
        self.bounces = NO;
        self.imagesBackView = [[UIView alloc]init];
        self.imagesBackView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.imagesBackView];
        for (NSString *imageName in self.imagesName) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:imageName];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.imageSArray addObject:imageView];
            [self.imagesBackView addSubview:imageView];
        }
        //初始化头视图及子控件布局
        CGFloat scale = [self.scaleArray[0] floatValue];
        CGFloat height = scale * self.width;
        [self imagesFrameArrayWithHeight:height andIndex:0];
    }
    return self;
}
-(void)imagesFrameArrayWithHeight:(CGFloat)height andIndex:(int)index
{
    self.height = height;
    self.contentSize = CGSizeMake(self.imagesName.count * self.width, height);
    
    double backWidth = 0;
    double backX = 0;
    for (int i = 0; i < self.scaleArray.count; i++) {
        double widthFrame = height / [self.scaleArray[i] doubleValue] ;
        CGRect frame = CGRectMake(backWidth, 0, widthFrame, height);
        backWidth += widthFrame;
        if (i==index) {
            backX = self.width * (index + 1) - backWidth ;
        }
        UIImageView *imageView = self.imageSArray[i];
        imageView.frame = frame;;
        
    }
    self.imagesBackView.frame = CGRectMake(backX , 0, backWidth, height);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int i = ((int)scrollView.contentOffset.x) / self.width;
    if (i < self.scaleArray.count - 1) {
        double X = scrollView.contentOffset.x  -  self.width * i;
        double scale = [self.scaleArray[i] floatValue];
        double scaleOne = [self.scaleArray[i + 1] floatValue];
        double height = scale * self.width  + (X / self.width) * (scaleOne -  scale) * self.width ;
        [self imagesFrameArrayWithHeight:height andIndex:i];
        if (self.heightChange) {
            self.heightChange(height);
        }
    }
}
@end
