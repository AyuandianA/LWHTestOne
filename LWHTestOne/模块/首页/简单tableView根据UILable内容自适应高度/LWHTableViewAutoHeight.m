//
//  LWHTableViewAutoHeight.m
//  LWHTestOne
//
//  Created by mac on 2020/5/9.
//  Copyright © 2020 BraveShine. All rights reserved.
//



#import "LWHTableViewAutoHeight.h"
#import "LWHTableViewCellAutoHeight.h"
@interface LWHTableViewAutoHeight ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LWHTableViewAutoHeight
+(instancetype)creatTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    return [[self alloc]initWithFrame:frame style:style];
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        //初始化自带属性
        [self chuShiHua];
    }
    return self;
}


//初始化自带属性
-(void)chuShiHua
{
    self.backgroundColor = [UIColor whiteColor];
    //设置代理
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSelectionStyleNone;
    self.separatorColor = MainBackColor;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.showsHorizontalScrollIndicator = NO;
    //自动布局两句代码
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100; //减少第一次计算量，iOS7后支持
    
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.rowHeight = UITableViewAutomaticDimension;
    self.showsVerticalScrollIndicator = NO;
    AdjustsScrollViewInsetNever([self viewController], self);
}

#pragma mark - Table view data source和代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.SourceArray.count) {
        return self.SourceArray.count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LWHTableViewCellAutoHeight *cell = (LWHTableViewCellAutoHeight *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LWHTableViewCellAutoHeight alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    NSString *content = self.SourceArray[indexPath.row];
    [cell setLableContent:content];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //自动布局一句代码
    return UITableViewAutomaticDimension;
}
-(NSMutableArray *)SourceArray
{
    if (!_SourceArray) {
        _SourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _SourceArray;
}
@end
