//
//  LWHProjectHeaderView.m
//  ChengXianApp
//
//  Created by mac on 2019/6/26.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "LWHProjectHeaderButtonsView.h"
#import "UIButton+SGPagingView.h"

@interface LWHProjectHeaderButtonsView ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *stringsArray;
@property (nonatomic,strong) NSMutableArray *imagesArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger lineNum;
@property (nonatomic,assign) NSInteger columnNum;
@property (nonatomic,assign) CGFloat ScaleHeightAndWidth;
@end
@implementation LWHProjectHeaderButtonsView

-(instancetype)initWithLineNum:(NSInteger)lineNum colunmNum:(NSInteger)columnNum scaleHeightAndWidth:(CGFloat)ScaleHeightAndWidth
{
    if (self = [super init]) {
        self.lineNum = lineNum;
        self.columnNum = columnNum;
        self.ScaleHeightAndWidth = ScaleHeightAndWidth;
        [self chuShiHua];
    }
    return self;
}

//初始化数据
-(void)chuShiHua
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    
    NSInteger hangNum = self.columnNum;
    
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    CGFloat width = (KScreenWidth  - marginX * 2 - marginX * 2)/hangNum;
    CGFloat totalHeight = marginY * 2 + (width * self.ScaleHeightAndWidth + marginY) * self.lineNum;
    CGFloat totalWidth = KScreenWidth - marginX * 2;
    self.frame = CGRectMake(0, 0, totalWidth, totalHeight);
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, totalWidth, totalHeight);
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView  = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, totalHeight - 20, KScreenWidth - 2 * marginX, 20)];
    pageControl.contentMode = UIViewContentModeCenter;
    pageControl.centerX = self.centerX;
    self.pageControl = pageControl;
    [self addSubview:pageControl];
    //设置小白点的个数
    pageControl.numberOfPages = 1;
    
    //设置当前选中的点
    pageControl.currentPage = 0;
    
    //设置当前选中的小白点的颜色
    pageControl.currentPageIndicatorTintColor = MainTopColor;
    
    //设置未选中小白点的颜色
    pageControl.pageIndicatorTintColor = MainBackColor;
    
    //用于控制是否只有一个页面时隐藏页面控件(默认值为NO)
    pageControl.hidesForSinglePage = YES;
    
    
    //添加点击事件
    [pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    
}
-(void)valueChanged:(UIPageControl *)page
{
    [self.scrollView setContentOffset:CGPointMake((KScreenWidth - 10 * 2) * page.currentPage, 0) animated:YES];
}
- (CGFloat)creatButtonViewsWithDataSourceArray:(NSArray *)stringsArray andImagesArray:(NSArray *)imagesArray
{
    NSInteger hangNum = self.columnNum;
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    CGFloat width = (KScreenWidth  - marginX * 2 - marginX * 2)/hangNum;
    CGFloat totalHeight = marginY * 2 + (width * self.ScaleHeightAndWidth + marginY) * self.lineNum;
    CGFloat totalWidth = (imagesArray.count / (self.lineNum * hangNum) + 1 )* (KScreenWidth - marginX * 2);
    [self.stringsArray removeAllObjects];
    [self.imagesArray removeAllObjects];
    [self.scrollView removeAllSubviews];
    if (stringsArray.count != 0 && imagesArray.count != 0 && stringsArray.count == imagesArray.count) {
        for (int j = 0; j < stringsArray.count; j++) {
            UIButton *imageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            imageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [imageButton setTitle:stringsArray[j] forState:(UIControlStateNormal)];
            [imageButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            
            NSURL* strUrl = [NSURL URLWithString:imagesArray[j]];
            [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
            imageButton.titleLabel.font = [UIFont systemFontOfSize:TextFont - 3];
            CGFloat kButtonWidth = j / (self.lineNum * hangNum)* (KScreenWidth - marginX * 2);
            CGFloat kButtonHeight = (j % (self.lineNum * hangNum)) / hangNum;
            imageButton.frame = CGRectMake(marginX + width * (j % hangNum) + kButtonWidth , marginY + (width * self.ScaleHeightAndWidth + marginY) * kButtonHeight, width, width * self.ScaleHeightAndWidth);
            imageButton.tag = 100 + j;
            __weak typeof(UIButton *)weakImageButton = imageButton;
            [imageButton setImageWithURL:strUrl forState:(UIControlStateNormal) placeholder:nil options:(YYWebImageOptionUseNSURLCache) completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {

                [weakImageButton SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:5 imagePositionBlock:^(UIButton *button) {

                }];
            }];

            
            [self.scrollView addSubview:imageButton];
        }
        
        [self.imagesArray addObjectsFromArray:imagesArray];
        [self.stringsArray addObjectsFromArray:stringsArray];
    }else{
    }
    self.scrollView.contentSize = CGSizeMake(totalWidth, totalHeight);
    self.pageControl.numberOfPages = imagesArray.count / (hangNum * self.lineNum) + 1;
    self.pageControl.currentPage = 0;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.pageControl.frame = CGRectMake(0, totalHeight - 20, KScreenWidth - 2 * marginX, 20);
    return totalHeight;
}

- (CGFloat)creatLableViewsWithDataSourceArray:(NSArray *)stringsArray
{
    NSInteger hangNum = self.columnNum;

    CGFloat marginX = 10;
    CGFloat marginY = 10;
    CGFloat width = (KScreenWidth  - marginX * 2 - marginX * 2)/hangNum;
    CGFloat totalHeight = marginY * 2 + (width * self.ScaleHeightAndWidth + marginY) * self.lineNum;
    CGFloat totalWidth = (stringsArray.count / (self.lineNum * hangNum) + 1 )* (KScreenWidth - marginX * 2);
    
    [self.stringsArray removeAllObjects];
    [self.scrollView removeAllSubviews];
    if (stringsArray.count != 0 ) {
        for (int j = 0; j < stringsArray.count; j++) {
            UIButton *imageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            imageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [imageButton setTitle:stringsArray[j] forState:(UIControlStateNormal)];
            [imageButton setTitleColor:RGB(230, 100, 50, 1) forState:(UIControlStateNormal)];
            [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
            imageButton.titleLabel.font = [UIFont systemFontOfSize:TextFont - 4];
            imageButton.layer.cornerRadius = 5;
            imageButton.backgroundColor = RGB(250, 238, 221, 1);
            
            CGFloat kButtonWidth = j / (self.lineNum * hangNum)* (KScreenWidth - marginX * 2);
            CGFloat kButtonHeight = (j % (self.lineNum * hangNum)) / hangNum;
            imageButton.frame = CGRectMake(marginX + width * (j % hangNum) + kButtonWidth , marginY + (width * self.ScaleHeightAndWidth + marginY) * kButtonHeight, width, width * self.ScaleHeightAndWidth);
//            CGFloat buttonWidth = [self getWidthWithTitle:stringsArray[j] font:[UIFont systemFontOfSize:TextFont - 4]];
            CGFloat buttonCenterX = imageButton.centerX;
//            if (buttonWidth + 5 < width) {
//                imageButton.width = buttonWidth  + 5;
//            }else{
//                imageButton.width = width - 5;
//            }
            imageButton.width = width - 5;
            imageButton.centerX = buttonCenterX;
            
            imageButton.tag = 100 + j;
            [self.scrollView addSubview:imageButton];
        }
        [self.stringsArray addObjectsFromArray:stringsArray];
    }else{
    }
    self.scrollView.contentSize = CGSizeMake(totalWidth, totalHeight);
    self.pageControl.numberOfPages = stringsArray.count / (hangNum * self.lineNum) + 1;
    self.pageControl.currentPage = 0;
    self.pageControl.frame = CGRectMake(0, totalHeight - 20, KScreenWidth - 2 * marginX, 20);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    return totalHeight;
}
-(void)imageButtonAction:(UIButton *)button{
    NSInteger index = button.tag - 100;
    if (self.myBlock) {
        self.myBlock(index);
    }
}

-(NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

-(NSMutableArray *)stringsArray
{
    if (!_stringsArray) {
        _stringsArray = [NSMutableArray array];
    }
    return _stringsArray;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x/(KScreenWidth - 2 * 10);
}
-(CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
@end
