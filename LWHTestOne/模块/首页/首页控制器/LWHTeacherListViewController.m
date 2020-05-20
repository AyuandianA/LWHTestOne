//
//  LWHTeacherListViewController.m
//  LWHTestOne
//
//  Created by mac on 2020/5/20.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHTeacherListViewController.h"
#import "LWHTeacherListTableViewCell.h"
@interface LWHTeacherListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *TeacherListSourceArray;

@end

@implementation LWHTeacherListViewController
#pragma mark 视图已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建控件
    [self ControllerKongJianBuJu];
    //获取数据源
    [self getDataSources];
}
#pragma mark 创建控件
-(void)ControllerKongJianBuJu
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    //设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorColor = MainBackColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.showsVerticalScrollIndicator = NO;
    AdjustsScrollViewInsetNever(self, self.tableView)
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark 获取数据源
-(void)getDataSources
{
    
}



#pragma mark - Table view data source和代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.TeacherListSourceArray.count) {
        return self.TeacherListSourceArray.count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LWHTeacherListTableViewCell *cell = (LWHTeacherListTableViewCell *)[LWHTeacherListTableViewCell creatTeacherListTableViewCellWithTableView:tableView ];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
-(NSMutableArray *)TeacherListSourceArray
{
    if (!_TeacherListSourceArray) {
        _TeacherListSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _TeacherListSourceArray;
}
@end
