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
    if (self.cellSections) {
        return self.cellSections();
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.cellRows) {
        return self.cellRows(section);
    }else{
        if (self.PublicSourceArray.count != 0) {
            return self.PublicSourceArray.count;
        }else{
            return 0;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id (*action)(id, SEL, id) = (id (*)(id, SEL, id)) objc_msgSend;
    SEL sel = sel_registerName("creatPublicTableViewCellWithTableView:");
    Class cellName = NSClassFromString(self.cellName);
    id cell = action(cellName,sel,tableView);
    id model = self.PublicSourceArray[indexPath.row];
    void (*actionTwo)(id, SEL, id) = (void (*)(id, SEL, id)) objc_msgSend;
    SEL selTwo = sel_registerName("changeDataWithModel:");
     actionTwo(cell,selTwo,model);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.tapSection) {
        self.tapSection(indexPath);
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.headerView) {
        return self.headerView(section);
    }else{
        return [UIView new];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.footerView) {
        return self.footerView(section);
    }else{
        return [UIView new];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.headerHeight) {
        return self.headerHeight(section);
    }else{
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.footerHeight) {
        return self.footerHeight(section);
    }else{
        return 0.01;
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollSection) {
        self.scrollSection();
    }
}
@end
