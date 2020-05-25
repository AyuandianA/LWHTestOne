//
//  LWHPublicTableViewCell.m
//  zhibo
//
//  Created by 李武华 on 2020/5/21.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHPublicTableViewCell.h"

@interface LWHPublicTableViewCell ()
@property (nonatomic,assign) CGFloat margin;
@end

@implementation LWHPublicTableViewCell

+(instancetype)creatPublicTableViewCellWithTableView:(UITableView *)tableView
{
    LWHPublicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LWHPublicTableViewCell class])];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[LWHPublicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([LWHPublicTableViewCell class])];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.margin = 10;
        //初始化控件
        [self chuShiHua];
    }
    return self;
}

//初始化数据
-(void)chuShiHua
{
}
-(void)changeDataWithModel:(id )model
{
    
}

-(void)changeDataWithModel:(id)model andSection:(NSIndexPath *)section
{
    
}
@end
