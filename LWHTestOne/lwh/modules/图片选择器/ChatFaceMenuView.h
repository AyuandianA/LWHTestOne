//
//  ChatFaceMenuView.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/7.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatFace;

@class ChatFaceMenuView;

@protocol ChatBoxFaceMenuViewDelegate <NSObject>
/**
 *  表情菜单界面的添加按钮点击事件
 */
- (void) chatBoxFaceMenuViewAddButtonDown;
/**
 *  发送事件
 */
- (void) chatBoxFaceMenuViewSendButtonDown;


- (void) chatBoxFaceMenuView:(ChatFaceMenuView *)chatBoxFaceMenuView didSelectedFaceMenuIndex:(NSInteger)index;

@end

@interface ChatFaceMenuView : UIView

@property (nonatomic, assign) id<ChatBoxFaceMenuViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *faceGroupArray;

@property (nonatomic, assign) int btnType;


@end
