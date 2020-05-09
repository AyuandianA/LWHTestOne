//
//  LWHFirstViewController.m
//  LWHTestOne
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 BraveShine. All rights reserved.
//

#import "LWHFirstViewController.h"
#import "BaseNaviController.h"
#import "UIImage+Category.h"
#import "UIImage+Category.h"
#import "LWHTarbarView.h"
#import "LWHScrollViewOne.h"
#import "LWHTableViewAutoHeight.h"
#import "LWHTableViewCellAutoHeight.h"
@interface LWHFirstViewController ()
//展示列表
@property (nonatomic,strong) LWHTableViewAutoHeight *tableView;
@end

@implementation LWHFirstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenReturnButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[LWHTableViewAutoHeight alloc]initWithFrame:CGRectMake(0, TopHeight + 20, KScreenWidth, 200) style:(UITableViewStylePlain)];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.SourceArray  = @[@"公司的法国人同一天",@"r而台湾而对方公司的感受到",@"分公司答复公司法告诉对方公司法规的三个大公司的公司的股份第三个分公司答复公司法告诉对方公司法规的三个大公司的公司的股份第三个分公司答复公司法告诉对方公司法规的三个大公司的公司的股份第三个分公司答复公司法告诉对方公司法规的三个大公司的公司的股份第三个",@"而台湾而对方公司的感受到而台湾而对方公司的感受到",@"而台湾而对方公司的感受到",@"发不发给你个"].mutableCopy;
    [self.tableView reloadData];
    LWHTableViewCellAutoHeight *cell = [[LWHTableViewCellAutoHeight alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    CGFloat heightAll = 0;
    for (NSString *content in self.tableView.SourceArray) {
        [cell setLableContent:content];
            //使用systemLayoutSizeFittingSize获取高度
        CGFloat heitht = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        heightAll += heitht;
    }
    self.tableView.height = heightAll;
    [self.view addSubview:self.tableView];
}



@end
