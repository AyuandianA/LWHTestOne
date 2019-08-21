//
//  CustomerTextView.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/6/6.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "CustomerTextView.h"

@interface CustomerTextView()
/** 占位文字label */
@property (nonatomic, strong)UILabel *placeholderLabel;

@end

@implementation CustomerTextView

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0;
//        _placeholderLabel.originX = 4;
//        _placeholderLabel.originY = 7;
        [self addSubview:_placeholderLabel];
     }
    
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
         // 垂直方向上永远有弹簧效果
         self.alwaysBounceVertical = YES;
         // 默认字体
         self.font = [UIFont systemFontOfSize:15];
         // 默认的占位文字颜色
         self.placeHolderColor = [UIColor grayColor];
         // 监听文字改变
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
     }
    
    return self;
}

- (void)dealloc{
       [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
* 监听文字改变
*/
- (void)textDidChange {
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
}

/**
* 更新占位文字的尺寸
*/
 - (void)updatePlaceholderLabelSize {
     
     CGSize maxSize = CGSizeMake(self.frame.size.width - 2 * self.placeholderLabel.frame.origin.x, MAXFLOAT);
     self.placeholderLabel.size = [self.placeHolder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
}

#pragma mark - 重写setter
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    
    _placeHolderColor = placeHolderColor;
    
    self.placeholderLabel.textColor = _placeHolderColor;
    
}
- (void)setPlaceHolder:(NSString *)placeHolder {
    
    _placeHolder = placeHolder;
    
    self.placeholderLabel.text = _placeHolder;
    
    [self updatePlaceholderLabelSize];
    
}
- (void)setPlaceHolderTextAlignment:(NSTextAlignment)placeHolderTextAlignment {
    
    _placeHolderTextAlignment = placeHolderTextAlignment;
    
    _placeholderLabel.textAlignment = _placeHolderTextAlignment;
    
    [self updatePlaceholderLabelSize];
}

- (void)setFont:(UIFont *)font {
     
    [super setFont:font];

    self.placeholderLabel.font = font;

    [self updatePlaceholderLabelSize];
}

- (void)setText:(NSString *)text {
     
    [super setText:text];

    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
     
    [super setAttributedText:attributedText];

    [self textDidChange];
}

@end
