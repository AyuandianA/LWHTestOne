//
//  LJCGIFRefreshHeader.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/7.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import "LJCGIFRefreshHeader.h"

@implementation LJCGIFRefreshHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
//    - (void)setTitle:(NSString *)title forState:(MJRefreshState)state;
//    /*
//     /** 普通闲置状态 */
//    MJRefreshStateIdle = 1,
//    /** 松开就可以进行刷新的状态 */
//    MJRefreshStatePulling,
//    /** 正在刷新中的状态 */
//    MJRefreshStateRefreshing,
//    /** 即将刷新的状态 */
//    MJRefreshStateWillRefresh,
//    /** 所有数据加载完毕，没有更多的数据了 */
//    MJRefreshStateNoMoreData
//     */
//    self.stateLabel.mj_x = 130;
    
    [self setTitle:@"          下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"          松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"          正在刷新" forState:MJRefreshStateRefreshing];
//    [self setTitle:@"拉不动了" forState:MJRefreshStateNoMoreData];
    
    self.labelLeftInset = -30;
   
    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];

     [idleImages addObject:[UIImage imageNamed:@"0@3x.png"]];
     [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 0; i < 23; i++) {
//        NSString *imgName = ;
        [refreshingImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]]];
    }
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:1.0 forState:MJRefreshStateRefreshing];
}
@end
