//
//  LWHPublicBaseTableView.m
//  zhibo
//
//  Created by 李武华 on 2020/5/24.
//  Copyright © 2020 李武华. All rights reserved.
//

#import "LWHPublicBaseTableView.h"

@implementation LWHPublicBaseTableView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}

@end
