//
//  ChatBoxFaceView.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/7.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatFace.h"
@protocol ChatBoxFaceViewDelegate <NSObject>

- (void) chatBoxFaceViewDidSelectedFace:(ChatFace *)face type:(TLFaceType)type;
- (void) chatBoxFaceViewDeleteButtonDown;
- (void) chatBoxFaceViewSendButtonDown;

@end

@interface ChatBoxFaceView : UIView

@property (nonatomic, assign) id<ChatBoxFaceViewDelegate>delegate;

@property (nonatomic, assign) int btnType;


@end
