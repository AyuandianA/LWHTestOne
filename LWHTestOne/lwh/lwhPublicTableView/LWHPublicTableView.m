//
//  LWHPublicTableView.m
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHPublicTableView.h"
#import <objc/message.h>
@interface LWHPublicTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LWHPublicTableView
+(instancetype)creatPublicTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style
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
    self.cellName = @"LWHPublicTableViewCell";
    //设置代理
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSelectionStyleNone;
    self.separatorColor = MainBackColor;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.showsHorizontalScrollIndicator = NO;
    self.estimatedRowHeight = 80;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.rowHeight = UITableViewAutomaticDimension;
    self.showsVerticalScrollIndicator = NO;
    AdjustsScrollViewInsetNever([self viewController], self)
}

#pragma mark - Table view data source和代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.PublicSourceArray.count) {
        return self.PublicSourceArray.count;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id (*action)(id, SEL, id) = (id (*)(id, SEL, id)) objc_msgSend;
    Class cellName = NSClassFromString(self.cellName);
    id cell = action(cellName,@selector(creatPublicTableViewCellWithTableView:),tableView);
    id model = self.PublicSourceArray[indexPath.row];
    void (*actionTwo)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
     actionTwo(cell,@selector(changeDataWithModel:),model);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.tapSection) {
        self.tapSection(indexPath);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(NSMutableArray *)PublicSourceArray
{
    if (!_PublicSourceArray) {
        _PublicSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _PublicSourceArray;
}
@end
