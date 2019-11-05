//
//  LLSearchViewController.m
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "LLSearchViewController.h"
#import "LSNavigationController.h"
#import "LLSearchSuggestionVC.h"
//#import "SearchResultViewController.h"
#import "LLSearchView.h"
#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]

@interface LLSearchViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UITextField *searchBar;
@property (nonatomic, strong) LLSearchView *searchView;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) LLSearchSuggestionVC *searchSuggestVC;

@end

@implementation LLSearchViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBarButtonItem];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.searchSuggestVC.view];
    [self addChildViewController:_searchSuggestVC];
    self.searchBar.text = self.searchString;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
    
    [self.searchBar becomeFirstResponder];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.searchBar removeObserver:self forKeyPath:@"text" context:nil];
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    NSLog(@"old : %@  new : %@",[change objectForKey:@"old"],[change objectForKey:@"new"]);
    [self textDidChange];
    
}
-(void)textDidChange
{
    if (self.searchBar.text == nil || [self.searchBar.text length] <= 0) {
        _searchSuggestVC.view.hidden = YES;
    } else {
        _searchSuggestVC.view.hidden = NO;
        [_searchSuggestVC searchTestChangeWithTest:self.searchBar.text];
    }
}
- (void)setBarButtonItem
{
    // 创建搜索框
    UIView *background = [[UIView alloc]initWithFrame:CGRectMake(10, 7, kScreenWidth-70, 30)];
    background.backgroundColor = [UIColor whiteColor];
    background.layer.cornerRadius = 5;
    background.layer.masksToBounds = YES;
    [self.navigationBar addSubview:background];
    self.background = background;
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-70, 30)];
    textField.placeholder = @"请输入项目名称";
    textField.font = [UIFont systemFontOfSize:TextFont];
    textField.delegate = self;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.returnKeyType = UIReturnKeySearch;
    // 调整左边间距
    CGRect frame = textField.frame;
    frame.size.width = 5;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
    [background addSubview:textField];
    self.searchBar = textField;
    [textField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    
    UIButton *cancleBtn = [[UIButton alloc]init];
    cancleBtn.frame = CGRectMake(0, 0, 60, 44);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancleBtn];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:) ];
    [self.searchView addGestureRecognizer:tap];
    __weak typeof(self)weakSelf = self;
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf.searchBar resignFirstResponder];
    }];
    swipeGR.direction = UISwipeGestureRecognizerDirectionUp;
    [self.searchView addGestureRecognizer:swipeGR];
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    [self.searchBar resignFirstResponder];
}

- (void)cancelBtnAction {
    
    [self.searchBar resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (void)cancelFirstResponder {

    [self.searchBar resignFirstResponder];
}

#pragma mark  点击 最近搜索&猜你想搜&热门搜索
- (void)pushToSearchResultWithSearchStr:(NSString *)str
{
    
    [self setHistoryArrWithStr:str];
    
    if (self.confirmBlock) {
        self.confirmBlock(str);
        [self.navigationController popViewControllerAnimated:NO];
    } else {
        
//        SearchResultViewController *result = [[SearchResultViewController alloc]init];
//        result.searchStr = str;
//        result.recommentArray = self.recommentArray;
//        result.hotArray = self.hotArray;
//        [self.navigationController pushViewController:result animated:NO];
        
    }
   
}

- (void)setHistoryArrWithStr:(NSString *)str
{
    if (![str isEqualToString:@""]) {
        for (int i = 0; i < _historyArray.count; i++) {
            if ([_historyArray[i] isEqualToString:str]) {
                [_historyArray removeObjectAtIndex:i];
                break;
            }
        }
        [_historyArray insertObject:str atIndex:0];
        [NSKeyedArchiver archiveRootObject:_historyArray toFile:KHistorySearchPath];
    }
    
}


#pragma mark - UISearchBarDelegate -



- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    _searchSuggestVC.view.hidden = YES;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self pushToSearchResultWithSearchStr:textField.text];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)recommentArray
{
    if (!_recommentArray) {
        _recommentArray = [NSMutableArray array];
    }
    return _recommentArray;
}
- (NSMutableArray *)hotArray
{
    if (!_hotArray) {
        self.hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

- (NSMutableArray *)historyArray
{
    if (!_historyArray) {
        _historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KHistorySearchPath];
        if (!_historyArray) {
            self.historyArray = [NSMutableArray array];
        }
    }
    return _historyArray;
}


- (LLSearchView *)searchView
{
    if (!_searchView) {
        self.searchView = [[LLSearchView alloc] initWithFrame:CGRectMake(0, StatusHeight + NaviH, KScreenWidth, KScreenHeight - StatusHeight - NaviH - SafeAreaH) hotArray:self.hotArray historyArray:self.historyArray guessArray:self.recommentArray];
        __weak LLSearchViewController *weakSelf = self;
        _searchView.tapAction = ^(NSString *str) {
            [weakSelf pushToSearchResultWithSearchStr:str];
        };
    }
    return _searchView;
}


- (LLSearchSuggestionVC *)searchSuggestVC
{
    if (!_searchSuggestVC) {
        self.searchSuggestVC = [[LLSearchSuggestionVC alloc] init];
        _searchSuggestVC.view.frame = CGRectMake(0, StatusHeight + NaviH, KScreenWidth, KScreenHeight - StatusHeight - NaviH - SafeAreaH);
        _searchSuggestVC.view.hidden = YES;
        __weak LLSearchViewController *weakSelf = self;
        _searchSuggestVC.searchBlock = ^(NSString *searchTest) {
            [weakSelf pushToSearchResultWithSearchStr:searchTest];
        };
    }
    return _searchSuggestVC;
}
@end
