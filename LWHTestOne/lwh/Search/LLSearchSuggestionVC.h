//
//  LLSearchSuggestionVC.h
//  LLSearchView
//
//  Created by 王龙龙 on 2017/7/25.
//  Copyright © 2017年 王龙龙. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SuggestSelectBlock)(NSString *searchTest);
@interface LLSearchSuggestionVC : BaseViewController
//回传搜索词
@property (nonatomic, copy) SuggestSelectBlock searchBlock;
//根据搜索词显示搜索建议
- (void)searchTestChangeWithTest:(NSString *)test;

@end
