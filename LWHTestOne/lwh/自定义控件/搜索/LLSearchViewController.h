//
//  LLSearchViewController.h
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

/***使用方法
 LLSearchViewController *searchCtrl = [[LLSearchViewController alloc]init];
 __weak typeof(self) weakSelf = self;
 searchCtrl.hotArray = self.hotArray;
 searchCtrl.recommentArray = self.recommentArray;
 searchCtrl.confirmBlock = ^(NSString *searchTest) {
 weakSelf.searchStr = searchTest;
 [weakSelf.searchBar setTitle:searchTest forState:(UIControlStateNormal)] ;
 [weakSelf setUpTableViewAllWithString:searchTest];
 };
 searchCtrl.searchString = self.searchStr;
 [self.navigationController pushViewController:searchCtrl animated:NO];
 */

#import "BaseViewController.h"

typedef void(^SelectSearchString)(NSString *searchTest);

@interface LLSearchViewController : BaseViewController

//回传搜索词,根据是否实现该block，决定是跳转新控制器，还是pop本控制器
@property (nonatomic, copy) SelectSearchString confirmBlock;
//创建该控制器的时候传入搜索词，会弹出搜索建议
@property (nonatomic,copy) NSString *searchString;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *recommentArray;

- (void)cancelFirstResponder;

- (void)setHistoryArrWithStr:(NSString *)str;
@end
