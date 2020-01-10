//
//  ChatFaceItemView.h
//  ChengXianApp
//
//  Created by Aliang Ren on 2019/5/7.
//  Copyright © 2019 Aliang Ren. All rights reserved.
//



/**
 *  这个View的 showFaceGroup:(ChatFaceGroup *)group formIndex:(int)fromIndex count:(int)count
 *  是通过组区分来添加表情Button，添加到这个View上。然后这一页的View再添加到 ChatBoxFaceView 上去。。。。
 */


#import <UIKit/UIKit.h>
#import "ChatFace.h"

@interface ChatFaceItemView : UIView

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) UIControlEvents controlEvents;

- (void) showFaceGroup:(ChatFaceGroup *)group formIndex:(int)fromIndex count:(int)count;
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
