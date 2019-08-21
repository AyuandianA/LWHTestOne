//
//  LJCGIFRefreshFooter.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/7.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import "MJRefreshBackGifFooter.h"

@implementation LJCGIFRefreshFooter

#pragma mark - 重写方法

- (void)prepare {
    
    [super prepare];
    
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"" forState:MJRefreshStatePulling];
    [self setTitle:@"" forState:MJRefreshStateRefreshing];
    [self setTitle:@"—————— • 已无更多数据 • ——————" forState:MJRefreshStateNoMoreData];
    self.stateLabel.textColor = RGB(238, 238, 238, 1);
    
    self.labelLeftInset = -20;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
   
    [idleImages addObject:[UIImage imageNamed:@"0@3x.png"]];
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 0; i < 23; i++) {
        [refreshingImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]]];
    }
    [self setImages:refreshingImages duration:1.0 forState:MJRefreshStateRefreshing];
}

@end
