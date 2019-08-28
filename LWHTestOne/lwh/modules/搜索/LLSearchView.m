//
//  LLSearchView.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchView.h"
#import "SGPagingView.h"
#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]
@interface LLSearchView ()<SGPageTitleViewDelegate>

@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) NSMutableArray *recommentArray;

@property (nonatomic, strong) UIView *recommentView;
@property (nonatomic, strong) UIView *searchHistoryView;
@property (nonatomic, strong) UIView *hotSearchView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;

@end
@implementation LLSearchView

- (instancetype)initWithFrame:(CGRect)frame hotArray:(NSMutableArray *)hotArr historyArray:(NSMutableArray *)historyArr guessArray:(NSMutableArray *)guessArray
{
    if (self = [super initWithFrame:frame]) {
        self.historyArray = historyArr;
        self.hotArray = hotArr;
        self.recommentArray = guessArray;
        [self addSubview:self.searchHistoryView];
        [self addSubview:self.hotSearchView];
        [self addSubview:self.recommentView];
        [self addSubview:self.pageTitleView];
    }
    return self;
}
-(UIView *)recommentView
{
    if (!_recommentView) {
        _recommentView = [self setViewWithOriginY:CGRectGetHeight(_searchHistoryView.frame)  textArr:self.recommentArray];
        
    }
    return _recommentView;
}

- (UIView *)hotSearchView
{
    if (!_hotSearchView) {
        self.hotSearchView = [self setViewWithOriginY:CGRectGetHeight(_searchHistoryView.frame)  textArr:self.hotArray];
        self.hotSearchView.hidden = YES;
        //橙现搜索
        UIButton *chengxianButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        chengxianButton.frame = CGRectMake(0, CGRectGetMaxY(self.hotSearchView.frame) + 50, self.hotSearchView.width, 40);
        [chengxianButton setTitle:@"" forState:(UIControlStateNormal)];
        [chengxianButton setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [chengxianButton setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        chengxianButton.titleLabel.font = [UIFont systemFontOfSize:TextFont];
        [self addSubview:chengxianButton];
    }
    return _hotSearchView;
}
-(SGPageTitleView *)pageTitleView{
    if (!_pageTitleView) {
        self.pageTitleView = [self setViewWithOriginY:CGRectGetHeight(_searchHistoryView.frame)];
    }
    return _pageTitleView;
}

- (UIView *)searchHistoryView
{
    if (!_searchHistoryView) {
        if (_historyArray.count > 0) {
            self.searchHistoryView = [self setViewWithOriginY:0 title:@"搜索历史" textArr:self.historyArray];
        } else {
            self.searchHistoryView = [self setNoHistoryView];
        }
    }
    return _searchHistoryView;
}
- (SGPageTitleView *)setViewWithOriginY:(CGFloat)height
{
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleFont = [UIFont boldSystemFontOfSize:TextFont];
    configure.titleGradientEffect = YES;
    configure.showBottomSeparator = NO;
    configure.titleSelectedFont = [UIFont boldSystemFontOfSize:TextFont ];
    configure.titleColor = [UIColor blackColor];
    configure.titleSelectedColor = MainTopColor;
    configure.indicatorColor = MainTopColor;
    configure.indicatorFixedWidth = 30;
    configure.indicatorStyle = SGIndicatorStyleFixed;
    CGFloat X = 15;
    SGPageTitleView *titleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(X, height, 175, 35) delegate:self titleNames:@[@"猜你想搜",@"热门搜索"] configure:configure];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.selectedIndex = 0;
    return titleView;
}
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex == 0) {
        self.hotSearchView.hidden = YES;
        self.recommentView.hidden = NO;
    }else{
        self.hotSearchView.hidden = NO;
        self.recommentView.hidden = YES;
    }
}

-(UIView *)setViewWithOriginY:(CGFloat)riginY  textArr:(NSMutableArray *)textArr
{
    UIView *view = [[UIView alloc] init];
    
    CGFloat y = 10 + 40;
    CGFloat letfWidth = 15;
    for (int i = 0; i < textArr.count; i++) {
        NSString *text = textArr[i];
        CGFloat width = [self getWidthWithStr:text] + 40;
        if (letfWidth + width + 15 > KScreenWidth) {
            if (y >= 130) {
                [self removeTestDataWithTextArr:textArr index:i];
                break;
            }
            y += 40;
            letfWidth = 15;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(letfWidth, y, width, 30)];
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:TextFont - 2];
        label.text = text;
        label.layer.cornerRadius = 15;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = RGB(30, 30, 30,1);
        label.backgroundColor = RGB(245, 245, 245, 1);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [view addSubview:label];
        letfWidth += width + 10;
    }
    view.frame = CGRectMake(0, riginY, KScreenWidth, y + 40);
    return view;
}

- (UIView *)setViewWithOriginY:(CGFloat)riginY title:(NSString *)title textArr:(NSMutableArray *)textArr
{
    UIView *view = [[UIView alloc] init];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, KScreenWidth - 30 - 45, 30)];
    titleL.text = title;
    titleL.font = [UIFont systemFontOfSize:TextFont weight:0.8];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    [view addSubview:titleL];
    
    if ([title isEqualToString:@"搜索历史"]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(KScreenWidth - 45, 10, 28, 30);
        [btn setImage:[UIImage imageNamed:@"删 除 (1)"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clearnSearchHistory:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    CGFloat y = 10 + 40;
    CGFloat letfWidth = 15;
    for (int i = 0; i < textArr.count; i++) {
        NSString *text = textArr[i];
        CGFloat width = [self getWidthWithStr:text] + 40;
        if (letfWidth + width + 15 > KScreenWidth) {
            if (y >= 130 && [title isEqualToString:@"搜索历史"]) {
                [self removeTestDataWithTextArr:textArr index:i];
                break;
            }
            y += 40;
            letfWidth = 15;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(letfWidth, y, width, 30)];
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:TextFont - 2];
        label.text = text;
        label.layer.cornerRadius = 15;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = RGB(30, 30, 30,1);
        label.backgroundColor = RGB(245, 245, 245, 1);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        [view addSubview:label];
        letfWidth += width + 10;
    }
    view.frame = CGRectMake(0, riginY, KScreenWidth, y + 40);
    return view;
}


- (UIView *)setNoHistoryView
{
    UIView *historyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    titleL.text = @"搜索历史";
    titleL.font = [UIFont systemFontOfSize:TextFont - 2];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentLeft;
    
    UILabel *notextL = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleL.frame) + 10, 100, 20)];
    notextL.text = @"无搜索历史";
    notextL.font = [UIFont systemFontOfSize:TextFont - 5];
    notextL.textColor = [UIColor lightGrayColor];
    notextL.textAlignment = NSTextAlignmentLeft;
    [historyView addSubview:titleL];
    [historyView addSubview:notextL];
    return historyView;
}

- (void)tagDidCLick:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    if (self.tapAction) {
        self.tapAction(label.text);
    }
}

- (CGFloat)getWidthWithStr:(NSString *)text
{
    CGFloat width = [text boundingRectWithSize:CGSizeMake(KScreenWidth, 40) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:TextFont - 5]} context:nil].size.width;
    return width;
}


- (void)clearnSearchHistory:(UIButton *)sender
{
    [self.searchHistoryView removeFromSuperview];
    self.searchHistoryView = [self setNoHistoryView];
    [_historyArray removeAllObjects];
    [NSKeyedArchiver archiveRootObject:_historyArray toFile:KHistorySearchPath];
    [self addSubview:self.searchHistoryView];
    CGRect frame = _hotSearchView.frame;
    frame.origin.y = CGRectGetHeight(_searchHistoryView.frame);
    _hotSearchView.frame = frame;
}

- (void)removeTestDataWithTextArr:(NSMutableArray *)testArr index:(int)index
{
    NSRange range = {index, testArr.count - index - 1};
    [testArr removeObjectsInRange:range];
    [NSKeyedArchiver archiveRootObject:testArr toFile:KHistorySearchPath];
}



@end
