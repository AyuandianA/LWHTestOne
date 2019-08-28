//
//  IssueDynamicToolBar.m
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/8/1.
//  Copyright © 2019 WuHua . All rights reserved.
//

#import "IssueDynamicToolBar.h"
#import "UIView+TL.h"
#import "ChatBoxFaceView.h"
#import "NSString+judgement.h"
#import "ChatFace.h"
#import "ChatFaceHeleper.h"
#import "CustomerTextView.h"

#define     CHATBOX_BUTTON_WIDTH        37
// 输入框默认高度
#define     HEIGHT_TEXTVIEW             TabbarH * 0.74
// 输入框限制高度
#define     MAX_TEXTVIEW_HEIGHT         104
// 表情面板
#define     FACE_VIEW_HEIGHT 215

@interface IssueDynamicToolBar ()<UITextViewDelegate,ChatBoxFaceViewDelegate> {
    NSRange _selectRange;
}

@property (nonatomic, strong)UIView *background;
@property (nonatomic, assign) CGRect keyboardFrame;
@property(strong, nonatomic)ChatBoxFaceView *faceView;
@property (nonatomic, strong) UIButton *faceButton;  //表情按钮
@property (nonatomic, strong) CustomerTextView *textView;

@end

@implementation IssueDynamicToolBar

- (void)dealloc {
   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (UIButton *)faceButton {
    
    if (!_faceButton) {
        _faceButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, TabbarH)];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
        [_faceButton addTarget:self action:@selector(faceButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceButton;
}

- (ChatBoxFaceView *)faceView {
    if (!_faceView) {
        _faceView = [[ChatBoxFaceView alloc] initWithFrame:CGRectMake(0, FACE_VIEW_HEIGHT, kScreenWidth, FACE_VIEW_HEIGHT)];
        _faceView.btnType = 1;
        [_faceView setDelegate:self];
    }
    return _faceView;
}

#pragma mark - ChatBoxFaceViewDelegate
- (void)chatBoxFaceViewDidSelectedFace:(ChatFace *)face type:(TLFaceType)type {
    
    if (type == TLFaceTypeEmoji) {
        
        [self addEmojiFace:face];
        
    }
    
}

- (void)chatBoxFaceViewDeleteButtonDown {
    
    [self deleteButtonDown];
    
}

- (void)chatBoxFaceViewSendButtonDown {
    
    [self hiddenView];
    
}

- (instancetype)initWithTextView:(CustomerTextView *)textView {
    
    if ([super init]) {
        
//        _curHeight = TabbarH;
        self.textView = textView;
        self.textView.delegate = self;
        
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0);
        
        self.backgroundColor = MainBackColor;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        line.backgroundColor = [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1];
        
        self.background = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, TabbarH)];
        self.background.backgroundColor = MainBackColor;
        [self.background addSubview:line];
        
        [self addSubview:self.background];
        [self addSubview:self.faceView];
        
        [self.background addSubview:self.faceButton];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    
    return self;
    
}

- (void)keyboardWillHide:(NSNotification *)notification{
    
    if (self.faceButton.selected) {
        [UIView animateWithDuration:.2 animations:^{
            
            self.frame = CGRectMake(0, kScreenHeight-SafeAreaH-TabbarH-FACE_VIEW_HEIGHT, kScreenWidth, SafeAreaH+TabbarH+FACE_VIEW_HEIGHT);
            self.faceView.frame = CGRectMake(0, TabbarH, kScreenWidth, FACE_VIEW_HEIGHT);
        
        }];
    } else {
        [self hiddenView];
    }
    
    
}

- (void)keyboardFrameWillChange:(NSNotification *)notification{
    
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGRect rect = self.background.frame;
    
    rect.origin.y = kScreenHeight-self.keyboardFrame.size.height-TabbarH;
    
    rect.size.height = self.keyboardFrame.size.height+TabbarH;
    
    self.frame = rect;
    
    self.faceView.frame = CGRectMake(0, FACE_VIEW_HEIGHT, kScreenWidth, FACE_VIEW_HEIGHT);
    
}
- (void)addEmojiFace:(ChatFace *)face {
    
    if (![self.textView isFirstResponder]) {
        
        NSMutableString *mStr = [[NSMutableString alloc]initWithString:self.textView.text];

        [mStr insertString:face.faceName atIndex:_selectRange.location];
        
        [self.textView setText:mStr];
        
        if (self.textView.frameHeight < self.textView.contentSize.height) {

            [self.textView scrollToBottom];

        }
        
        _selectRange = NSMakeRange(_selectRange.location+face.faceName.length, 0);
        
    }
    
}
- (void)deleteButtonDown {
    
    if ([self.textView isFirstResponder]) {
        [self textView:self.textView shouldChangeTextInRange:NSMakeRange(self.textView.text.length - 1, 1) replacementText:@""];
    } else {
        if (_selectRange.location > 0) {
            [self textView:self.textView shouldChangeTextInRange:NSMakeRange(_selectRange.location-1, 1) replacementText:@""];
        }
        
    }
  
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    self.faceButton.selected = NO;
    
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    
    if ([self.textView isFirstResponder]) {

        _selectRange = textView.selectedRange;

    }

}
//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (textView.text.length > 0 && [text isEqualToString:@""]) {       // delete
        
        if ([textView.text characterAtIndex:range.location] == ']') {
            
            NSUInteger location = range.location;
            
            NSUInteger length = range.length;
            
            while (location != 0) {
                
                location --;
                
                length ++ ;
                
                char c = [textView.text characterAtIndex:location];
                
                if (c == '[') {
                    
                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    
                    _selectRange = NSMakeRange(location, 0);
                    self.textView.selectedRange = _selectRange;
                    
                    return NO;
                    
                }  else if (c == ']') {
                    
                    return YES;
                }
            }
        } else {
            
            if (![self.textView isFirstResponder]) {
                textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(_selectRange.location-1, 1) withString:@""];
                
                _selectRange = NSMakeRange(_selectRange.location-1, 0);
                self.textView.selectedRange = _selectRange;
                return NO;
            }
            
        }
    }
    
    return YES;
}
- (void)hiddenView {

    _selectRange = NSMakeRange(0, 0);
    
    [UIView animateWithDuration:.3 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.frame.size.height);
    }];
 
}
/**
 *  表情按钮点击事件
 */
- (void)faceButtonDown:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [self.textView resignFirstResponder];
        
    } else {
       
        [self.textView becomeFirstResponder];
    }
    
}


@end
