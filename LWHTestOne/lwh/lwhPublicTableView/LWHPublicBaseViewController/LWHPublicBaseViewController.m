//
//  LWHPublicBaseViewController.m
//  zhibo
//
//  Created by 李武华 on 2020/5/24.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHPublicBaseViewController.h"
#import "BaseNaviController.h"
#import "LWHPublicBaseTwoViewController.h"
@interface LWHPublicBaseViewController ()<UITableViewDataSource,UITableViewDelegate,SGPageTitleViewDelegate,SGPageContentScrollViewDelegate>

@property (nonatomic,assign) BOOL canScroller;
@end

@implementation LWHPublicBaseViewController
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
    [self.navigationBar setShadowImage:[UIImage new]];
    self.canScroller = YES;
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectorppp) name:@"adsfsdfasdf" object:nil];
    AdjustsScrollViewInsetNever(self, _tableView);
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleClassView.delegatePageTitleView = self;
    self.sgscrollView.delegatePageContentScrollView = self;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(LWHPublicBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[LWHPublicBaseTableView alloc]initWithFrame:CGRectMake(0, StatusHeight, KScreenWidth, KScreenHeight - StatusHeight - BottomHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        //设置代理
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.separatorColor = MainBackColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0,0,0);
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}


-(NSMutableArray *)contArray
{
    if (!_contArray) {
        _contArray = [NSMutableArray array];
    }
    return _contArray;
}
#pragma mark - Table view data source和代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    [cell addSubview:self.titleClassView];
    [cell addSubview:self.sgscrollView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScreenHeight - TopHeight - BottomHeight ;
}
-(void)selectorppp
{
    self.canScroller = YES;
    [self subTabviewcanScr:NO];
}
-(void)subTabviewcanScr:(BOOL)canScr
{
    for (LWHPublicBaseTwoViewController *subVC in self.contArray) {
        subVC.canScroll = canScr;
        if (!canScr) {
            subVC.tableView.contentOffset = CGPointZero;
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>self.tableView.tableHeaderView.height) {
            scrollView.contentOffset = CGPointMake(0, self.tableView.tableHeaderView.height);
            if (self.canScroller) {
                self.canScroller = NO;
                [self subTabviewcanScr:YES];
            }
        }else{
            if (!self.canScroller) {
                scrollView.contentOffset = CGPointMake(0, self.tableView.tableHeaderView.height);
            }
        }
}
#pragma - mark  SGPageTitleViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    
    [self.sgscrollView setPageContentScrollViewCurrentIndex:selectedIndex];

}
#pragma - mark  SGPageContentScrollViewDelegate


- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    if (self.titleClassView.selectedIndex != index) {
        self.titleClassView.selectedIndex = index;
    }
    
}
@end
