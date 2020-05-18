//
//  LWHAutoHeightCollectionViewCell.m
//  LWHTestOne
//
//  Created by 李武华 on 2020/5/17.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHAutoHeightCollectionViewCell.h"

@interface LWHAutoHeightCollectionViewCell ()
@property (nonatomic,strong) UILabel *labless;
@end
@implementation LWHAutoHeightCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //初始化控件
        [self chuShiHua];
    }
    return self;
}

//初始化数据
-(void)chuShiHua
{
    self.backgroundColor = [UIColor whiteColor];
    //初始化控件
    CGFloat maxWidth = KScreenWidth - 10 * 2;
    self.labless = [[UILabel alloc]init];
    self.labless.font = [UIFont systemFontOfSize:TextFont - 3 weight:-0.3];
    self.labless.textColor = [UIColor yellowColor];
    //自动布局三句代码
    self.labless.numberOfLines = 0;
    self.labless.preferredMaxLayoutWidth = maxWidth;
    [self.labless setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:UILayoutConstraintAxisVertical];
    [self.contentView addSubview:self.labless];
    [self.labless mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
//        make.width.mas_equalTo(maxWidth);
    }];
}

-(void)AutoHeightViewModelss:(NSString *)string
{
    self.labless.text = string;
}


@end

