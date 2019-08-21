//
//  EmptyView.m
//  YiMeiZhiBo
//
//  Created by Aliang Ren on 2018/3/23.
//  Copyright © 2018年 史德萌. All rights reserved.
//

#import "EmptyView.h"

@interface EmptyView() {
    NSString *_title;
    UIImage *_image;
    CGFloat _imgWidth;
    CGFloat _imgHeight;
}

@property(nonatomic,strong)UIButton  *btn;
//@property(nonatomic,strong)UIButton  *returnBtn;
@property(nonatomic,strong)UILabel *label;

@end

@implementation EmptyView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImg:(NSString *)imgName {
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.hidden = YES;
        
        if (title) {
            _title = title;
        } else {
            _title = @"暂无数据";
        }
        
        if (!imgName) {
            imgName = @"refresh_normal.png";
        }
        
        _image = BundleTabeImage(imgName);
        _imgWidth = _image.size.width > 100 ? 100 : _image.size.width < 50 ? 50 : _image.size.width;
        _imgHeight = _image.size.width > 100 ? (_image.size.height*100)/_image.size.width : _image.size.height < 50 ? 50 : _image.size.height;
       
        [self createSubViews];
        
    }
    
    return self;
}
- (void)createSubViews {
    
    self.btn = [UIButton buttonWithType: UIButtonTypeCustom];
    self.btn.frame = CGRectMake((self.width-_imgWidth)/2, (self.height-_imgHeight-25)/2, _imgWidth, _imgHeight);
    [self.btn setImage:_image forState:UIControlStateNormal];
    [self.btn setImage:_image forState:UIControlStateNormal|UIControlStateHighlighted];
    [self.btn addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btn.frame)+5, self.width, 20)];
    self.label.text = _title;
    self.label.font = [UIFont systemFontOfSize:TextFont];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor lightGrayColor];
    [self addSubview:self.label];
    
}
- (void)changeImageName:(NSString *)name frame:(CGSize)size title:(NSString *)tit {
    
    if (!name) {
        name = @"refresh_normal.png";
    }
    
    _image = BundleTabeImage(name);
    
    _imgWidth = _image.size.width > 100 ? 100 : _image.size.width < 50 ? 50 : _image.size.width;
    _imgHeight = _image.size.width > 100 ? (_image.size.height*100)/_image.size.width : _image.size.height < 50 ? 50 : _image.size.height;
    
    self.btn.frame = CGRectMake((self.width-_imgWidth)/2, (self.height-_imgHeight-25)/2, _imgWidth, _imgHeight);
    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.btn.frame)+5, self.width, 20);
    [self.btn setImage:_image forState:UIControlStateNormal];
    [self.btn setImage:_image forState:UIControlStateNormal|UIControlStateHighlighted];
    if (tit) {
        self.label.text = tit;
    }
    
}
//- (void)backAction {
//    
//    [self.baseVc.navigationController popViewControllerAnimated:YES];
//    
//}

- (void)refreshData {
    self.rBlock();
}



@end
