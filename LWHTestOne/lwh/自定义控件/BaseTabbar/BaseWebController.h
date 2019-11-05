//
//  BaseWebController.h
//  CollectFans
//
//  Created by 李威 on 16/12/9.
//  Copyright © 2016年 liwei. All rights reserved.
//

#import "BaseViewController.h"
//#import <WebKit/WebKit.h>
@interface BaseWebController : BaseViewController

@property (copy, nonatomic)NSString *urlStr; // 链接
@property (nonatomic, assign) NSUInteger loadCount;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) UIProgressView *progressView; // 进度条

@end
