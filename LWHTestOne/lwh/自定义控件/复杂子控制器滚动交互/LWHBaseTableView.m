//
//  LWHBaseTableView.m
//  LWHTestOne
//
//  Created by mac on 2020/5/19.
//  Copyright © 2020 BraveShine. All rights reserved.
//

#import "LWHBaseTableView.h"

@implementation LWHBaseTableView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}


@end
