//
//  LWHComplexScrollerViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/19.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHComplexScrollerViewController.h"
#import "LWHBaseTableView.h"
#import "SGPageContentScrollView.h"
#import "LWHComplexSubViewController.h"
@interface LWHComplexScrollerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) LWHBaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *contArray;
@property (nonatomic,strong) SGPageContentScrollView *sgscrollView;
@end

@implementation LWHComplexScrollerViewController
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
    self.tableView.canScroll = YES;
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selector) name:@"adsfsdfasdf" object:nil];
    AdjustsScrollViewInsetNever(self, _tableView);
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(LWHBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[LWHBaseTableView alloc]initWithFrame:CGRectMake(0, -TopHeight, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
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
//        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
//        headerView.backgroundColor = [UIColor redColor];
//        _tableView.tableHeaderView =  headerView;
    }
    return _tableView;
}
-(SGPageContentScrollView *)sgscrollView
{
    if (!_sgscrollView) {
        for (int i = 0; i < 5; i++) {
            LWHComplexSubViewController *subCtr = [[LWHComplexSubViewController  alloc]init];
            
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

    self.tableView.canScroll = YES;
    [self subTabviewcanScr:NO];
}
-(void)subTabviewcanScr:(BOOL)canScr
{
    for (LWHComplexSubViewController *subVC in self.contArray) {
        subVC.canScroll = canScr;
//        if (!canScr) {
//            subVC.tableView.contentOffset = CGPointZero;
//        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = 200;
        if (scrollView.contentOffset.y>height) {
//            scrollView.contentOffset = CGPointMake(0, height);
            if (self.tableView.canScroll) {
                self.tableView.canScroll = NO;
                [self subTabviewcanScr:YES];
            }
        }else{
//            if (!self.canScroller) {
//                scrollView.contentOffset = CGPointMake(0, height);
//            }
        }
}
@end
