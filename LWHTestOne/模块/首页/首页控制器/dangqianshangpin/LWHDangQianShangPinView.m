
//
//  LWHDangQianShangPinView.m
//  zhibo
//
//  Created by 李武华 on 2020/5/26.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHDangQianShangPinView.h"

@interface LWHDangQianShangPinView ()
@property (nonatomic,strong) UILabel *topLable;
@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *kuCunLable;
@property (nonatomic,strong) YYLabel *priceLable;

@end
@implementation LWHDangQianShangPinView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubLabless];
    }
    return self;
}
-(void)creatSubLabless
{
    self.layer.cornerRadius = 10;
    
    CGFloat margin = 10;
    
    
    
}
@end
