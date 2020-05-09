//
//  LWHTableViewCellAutoHeight.m
//  LWHTestOne
//
//  Created by mac on 2020/5/9.
//  Copyright © 2020 BraveShine. All rights reserved.
//
///tableView自动布局六行代码
//cell里面三句
//textLabel.numberOfLines = 0;
//textLabel.preferredMaxLayoutWidth = maxWidth;
//[textLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//tableView里三句
//tableView.rowHeight = UITableViewAutomaticDimension;
//tableView.estimatedRowHeight = 80; //减少第一次计算量，iOS7后支持
//return UITableViewAutomaticDimension

#import "LWHTableViewCellAutoHeight.h"
@interface LWHTableViewCellAutoHeight ()
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UILabel *bottomLable;
@end
@implementation LWHTableViewCellAutoHeight

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor blueColor];
        [self creatSubViews];
    }
    return self;
}
-(void)creatSubViews
{
    self.topView = [[UIView alloc]init];
    self.topView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    CGFloat maxWidth = KScreenWidth - 10 * 2;
    self.bottomLable = [[UILabel alloc]init];
    self.bottomLable.font = [UIFont systemFontOfSize:TextFont - 3 weight:-0.3];
    self.bottomLable.textColor = [UIColor yellowColor];
    //自动布局三句代码
    self.bottomLable.numberOfLines = 0;
    self.bottomLable.preferredMaxLayoutWidth = maxWidth;
    [self.bottomLable setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:UILayoutConstraintAxisVertical];
    [self.contentView addSubview:self.bottomLable];
    [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
}
-(void)setLableContent:(NSString *)content
{
    self.bottomLable.text = content;
}

@end
