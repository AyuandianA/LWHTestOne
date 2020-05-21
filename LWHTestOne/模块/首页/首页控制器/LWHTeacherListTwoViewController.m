//
//  LWHTeacherListTwoViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/21.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHTeacherListTwoViewController.h"
#import "LWHTeacherListTwoTableView.h"
#import "SGPageContentScrollView.h"
#import "BaseNaviController.h"
#import "LWHTeacherListTwoSubViewController.h"
@interface LWHTeacherListTwoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) BOOL canScroller;
@property (nonatomic,strong) LWHTeacherListTwoTableView *tableView;
@property (nonatomic,strong) NSMutableArray *contArray;
@property (nonatomic,strong) SGPageContentScrollView *sgscrollView;
@end

@implementation LWHTeacherListTwoViewController
#pragma mark 视图已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建控件
    [self ControllerKongJianBuJu];
}
#pragma mark 创建控件
-(void)ControllerKongJianBuJu
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.canScroller = YES;
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selector) name:@"adsfsdfasdf" object:nil];
    AdjustsScrollViewInsetNever(self, _tableView);
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(LWHTeacherListTwoTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[LWHTeacherListTwoTableView alloc]initWithFrame:CGRectMake(0, TopHeight, KScreenWidth, KScreenHeight - TopHeight - BottomHeight) style:UITableViewStylePlain];
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
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
        headerView.backgroundColor = [UIColor redColor];
        _tableView.tableHeaderView =  headerView;
    }
    return _tableView;
}
-(SGPageContentScrollView *)sgscrollView
{
    if (!_sgscrollView) {
        for (int i = 0; i < 5; i++) {
            LWHTeacherListTwoSubViewController *subCtr = [[LWHTeacherListTwoSubViewController  alloc]init];
            
            [self.contArray addObject: subCtr];
        }
        _sgscrollView = [[SGPageContentScrollView  alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth    , KScreenHeight - TopHeight - BottomHeight) parentVC:self childVCs:self.contArray];
        [_sgscrollView setPageContentScrollViewCurrentIndex:0];
    }
    return _sgscrollView;
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
    [cell addSubview:self.sgscrollView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KScreenHeight - TopHeight - BottomHeight ;
}
-(void)selector
{

    self.canScroller = YES;
    [self subTabviewcanScr:NO];
}
-(void)subTabviewcanScr:(BOOL)canScr
{
    for (LWHTeacherListTwoSubViewController *subVC in self.contArray) {
        subVC.canScroll = canScr;
        if (!canScr) {
            subVC.tableView.contentOffset = CGPointZero;
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = 200;
        if (scrollView.contentOffset.y>height) {
            scrollView.contentOffset = CGPointMake(0, height);
            if (self.canScroller) {
                self.canScroller = NO;
                [self subTabviewcanScr:YES];
            }
        }else{
            if (!self.canScroller) {
                scrollView.contentOffset = CGPointMake(0, height);
            }
        }
}
@end
