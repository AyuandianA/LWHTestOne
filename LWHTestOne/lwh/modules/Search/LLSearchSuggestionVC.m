//
//  LLSearchSuggestionVC.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchSuggestionVC.h"
#import "LSNavigationController.h"

@interface LLSearchSuggestionVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic, copy)   NSString *searchTest;

@end

@implementation LLSearchSuggestionVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    [self.view addSubview:self.contentView];
    
}

- (void)searchTestChangeWithTest:(NSString *)test
{
    //网络请求搜索建议
    _searchTest = test;
    [self loadDataWithKeyword:test];
}

- (void)loadDataWithKeyword:(NSString *)keyword{
    
    NSDictionary *parameter = @{
                                @"keyword":keyword
                                };
    __weak typeof(self)weakSelf = self;
    [LJCNetWorking POST_URL:@"Get_Search" params:parameter dataBlock:^(id data) {
//        NSLog(@"--------%@",data[@"data"]);
        if (data[@"data"][@"list"]) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.dataArray addObjectsFromArray:data[@"data"][@"list"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.contentView reloadData];
            });
        }
        
        
    }];
    
}
#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count != 0) {
        return self.dataArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    NSString *content = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"content"]];
    NSMutableAttributedString *contentMabString = [[NSMutableAttributedString alloc]initWithString:content];
    [contentMabString setColor:MainTopColor range:[content rangeOfString:self.searchTest]];
    cell.textLabel.attributedText = contentMabString;
    cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image.bundle/search_gray" ofType:@"png"]];
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *content =  [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"content"]];
    if (self.searchBlock) {
        self.searchBlock(content);
    }
}
- (UITableView *)contentView
{
    if (!_contentView) {
        _contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.tableFooterView = [UIView new];
    }
    return _contentView;
}
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
    
}



@end
